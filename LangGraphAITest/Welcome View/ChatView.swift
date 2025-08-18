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
    NavigationView {
        VStack {
            ScrollView {
                if viewModel.displayChatResponse.isEmpty {
                    Text("Hello human!")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    Text(viewModel.displayChatResponse)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .transition(.opacity)
                }
            }
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
            .padding()

            HStack {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $inputText)
                        .frame(height: 100)
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(UIColor.systemGray4), lineWidth: 1)
                        )
                    if inputText.isEmpty {
                        Text("Enter your question...")
                            .foregroundColor(.gray)
                            .padding(.top, 8)
                            .padding(.leading, 5)
                    }
                }

                Button(action: {
                    Task {
                        await viewModel.askLLM(question: inputText)
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8))
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
                .padding(.leading)
                }
            .padding()
        }
        .navigationTitle("LangGraph Chat")
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
}
#Preview {
    ChatView()

}
