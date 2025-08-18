//
//  ChatView.swift
//
//  Created by Francois Everhard Air on 6/1/25.
//

import SwiftUI

struct ChatView: View {

    @StateObject var viewModel  = ChatViewModel()
    @State var inputText: String = ""

    var body: some View {
        VStack {
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
        .alert(isPresented: .constant(viewModel.errorMessage != nil), content: {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage ?? ""),
                dismissButton: .default(Text("OK")) {
                    viewModel.errorMessage = nil
                }
            )
        })

    }
}
#Preview {
    ChatView()

}
