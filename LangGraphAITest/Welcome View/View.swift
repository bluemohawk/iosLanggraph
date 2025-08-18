//
//  View_Template.swift
//
//  Created by Francois Everhard Air on 6/1/25.
//

// Description
//This is an example of a View_Template file.
// 1. it is a struct
// 2. it owns its ViewModel
// 3. it describes how the view looks like

// Main Implementation Steps:
// - assign its ViewModel

import SwiftUI

//1.
struct View_Template: View {
    
    //2. The View_Template owns its ViewModel_Template
    @StateObject var viewModel  = ViewModel_Template()
    @State var inputText: String = ""
    
    //3.
    var body: some View {
        
        TextField(
            "Enter your message to LangGraph",text: $inputText
        )
        .padding(.horizontal, 11.0)
        .frame(width: 300, height: 200)
        .background(Color.blue.opacity(0.2))
        .cornerRadius(30)
    

        
        Button(action: {
            Task {
                await viewModel.askLLM(question: inputText)
            }
        }, label: {
            Text("Ask LangGraph")
        })
        
        
        TextField(
            "Here is LangGraph Answer",text: $viewModel.displayChatResponse
        )
        .padding(.horizontal, 11.0)
        .frame(width: 300, height: 200)
        .background(Color.pink.opacity(0.2))
        .cornerRadius(30)
        
        TextEditor(text: $viewModel.displayChatResponse)
            .frame(width: 300, height: 200)
            .scrollContentBackground(.hidden)
            .background(Color.pink.opacity(0.2))
            .allowsHitTesting(false)
            .font(.body)
            .border(Color.blue, width: 2)
            .cornerRadius(30)
            .lineSpacing(CGFloat(10))
            
        
    }
}
#Preview {
    View_Template()
    
}

