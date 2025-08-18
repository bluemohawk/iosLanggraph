//
//  ViewModel_Template.swift
//
//  Created by Francois Everhard Air on 6/1/25.


// Description
//This is an example of a ViewModel file.
// 1. it is a class
// 2. it conforms to ObservableObject
// 3. it publishes changes of var so to the view that depends on
// 4. it holds access to its Model data (not the view) and api service layer
// 5. it has an init function that its view can call to
// 6. it executes functions, inc API calls

// Main Implementation Steps:
// - list the variables that are published to the view
// - keep a re
// - implement the functions, inc api service layer functions (use @MainActor for async functions)
// -

import Foundation
//import Combine
import SwiftUI

//1.
class ViewModel_Template: ObservableObject { // 2. With ObservableObject, you're signaling that this object's properties, when changed, should trigger a refresh of any views that depend on them.
    
    //3.Whenever the @Published properties change in ViewModel, the View will re-rerender the view's body.
    @Published var displayChatResponse: String = ""
    
    //4.
    private var chatLLM = api_langgraph()
    
    
    //5.
    //    init()
    
    //6.
    func askLLM(question: String) async {
        
        do {
            let LLMResponse = try await chatLLM.API_Post_langgraph(chatRequest:ChatRequest(message: question))
            displayChatResponse = LLMResponse.response
            
        } catch {
            
        }
    }
    
    
}



