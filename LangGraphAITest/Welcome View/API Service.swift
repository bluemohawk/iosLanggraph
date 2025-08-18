//
//  APIService_Template.swift
//
//  Created by Francois Everhard Air on 8/4/25.
//

import Foundation

// Description
// 1. it's a class
// 2. it takes a whole url, alternatively, it builds on a base url and add a variable (see alternative).
// 3. it uses a data model (struct conforming to codable) for coding and decoding the returned value (see Model_forAPI_Template for additional information).
// 4. it uses an enum to catch different error messages.

// Main Implementation Steps:
//  - provide base url and parameters
//  - provide a data model struct conforming to Codable protocol as separate file

enum apiError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
}

class APIService_Template {
    
    //    Alternative building on a base URL, adding variable (e.g. id) to it.
    //    private let baseURL = URL(string: "https://api.github.com/users/")!
    //
    func fetchDataFromID(id: String) async throws -> Model_forAPI_Template {
        
        guard let baseURL = URL(string: "https://api.github.com/users/") else {
            print("invsald url !!")
            throw apiError.invalidURL
        }
        
        guard let url = URL(string: "\(id)", relativeTo: baseURL) else {
            throw apiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw apiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Model_forAPI_Template.self, from: data)
        } catch {
            throw apiError.invalidData
        }
        
    }
    
    
    func fetchDataFromAPI(from url: String) async throws -> Model_forAPI_Template {
        
        guard let baseURL = URL(string: "https://api.github.com/users/bluemohawk") else {
            throw apiError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: baseURL)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw apiError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(Model_forAPI_Template.self, from: data)
        } catch {
            throw apiError.invalidData
        }
        
    }
    
    
}
