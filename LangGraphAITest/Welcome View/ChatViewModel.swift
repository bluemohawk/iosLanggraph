//
//  ChatViewModel.swift
//
//  Created by Francois Everhard Air on 6/1/25.


import Foundation
//import Combine
import SwiftUI

class ChatViewModel: ObservableObject {

    @Published var displayChatResponse: String = ""
    @Published var errorMessage: String?

    private let chatLLM: LangGraphServiceProtocol

    init(chatLLM: LangGraphServiceProtocol = api_langgraph()) {
        self.chatLLM = chatLLM
    }

    @MainActor
    func askLLM(question: String) async {

        do {
            let LLMResponse = try await chatLLM.API_Post_langgraph(chatRequest:ChatRequest(message: question))
            displayChatResponse = LLMResponse.response
            errorMessage = nil

        } catch {
            displayChatResponse = ""
            errorMessage = "Error: \(error.localizedDescription)"
        }
    }

    @MainActor
    func startNewConversation() {
        chatLLM.startNewConversation()
        displayChatResponse = ""
        errorMessage = nil
    }


}
