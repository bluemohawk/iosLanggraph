//
//  langgraph.swift
//  apiTest
//
//  Created by Francois Everhard Air on 8/16/25.
//
import Foundation


// MARK: - Data Models for Request and Response from LangGraph

/// A Codable struct to represent the message we are sending to the API.
/// The `text` field will hold the user's chat message.
struct ChatRequest: Codable {
    let query: String
    var session_id: String?
    
    init(message: String) {
        self.query = message
    }
}

struct ChatResponse: Codable {
    let response: String
    let session_id: String
}


// MARK: - API LangGraph Service

protocol LangGraphServiceProtocol {
    func API_Post_langgraph(chatRequest: ChatRequest) async throws -> ChatResponse
    func startNewConversation()
}

/// A service to handle the network call to the LangGraph chat app.
class api_langgraph: LangGraphServiceProtocol {

    private let sessionIDKey = "chat_session_id"

    private var currentSessionID: String? {
        get {
            UserDefaults.standard.string(forKey: sessionIDKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: sessionIDKey)
        }
    }

    func startNewConversation() {
        self.currentSessionID = nil
    }
    
    func API_Post_langgraph(chatRequest: ChatRequest) async throws -> ChatResponse {
        
        /// The URL for the local server endpoint.
        /// Note: `localhost` is a special name that resolves to `127.0.0.1`.
        let urlString = "http://127.0.0.1:8000/query"
        
        guard let url = URL(string: urlString) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var requestBody = chatRequest
        if let sessionID = self.currentSessionID {
            requestBody.session_id = sessionID
        }

        let jsonData: Data
        do {
            jsonData = try JSONEncoder().encode(requestBody)
            request.httpBody = jsonData
        } catch {
            print("Error encoding JSON")
            throw APIError.encodingError(error)
        }
        
        // Start the network task.
        let (data, response): (Data, URLResponse)
        do {
            (data, response) = try await URLSession.shared.data(for: request)
        } catch {
            throw APIError.networkError(error)
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }
        
        print("Status code: \(httpResponse.statusCode)")
        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.serverError(httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            let chatResponse = try decoder.decode(ChatResponse.self, from: data)
            self.currentSessionID = chatResponse.session_id
            print("Response: status=\(chatResponse.response)")
            return chatResponse
        } catch {
            print("Error decoding response: \(error)")
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("Raw response: \(responseString)")
            }
            throw APIError.decodingError(error)
        }
    }
    
}


/// Custom API errors for better error handling
enum APIError: Error {
    case invalidURL
    case encodingError(Error)
    case networkError(Error)
    case invalidResponse
    case serverError(Int)
    case decodingError(Error)
}
