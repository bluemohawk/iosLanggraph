//
//  ChatView.swift
//
//  Created by Francois Everhard Air on 6/1/25.
//

import SwiftUI

struct ChatView: View {

    @StateObject var viewModel  = ChatViewModel()
    @State var inputText: String = ""

    init() {
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            Color(red: 17/255, green: 25/255, blue: 34/255)
                .edgesIgnoringSafeArea(.all)

            VStack {
                ScrollView {
                    if viewModel.displayChatResponse.isEmpty {
                        Text("Hello human!")
                            .font(.title)
                            .foregroundColor(Color(white: 0.8))
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        Text(viewModel.displayChatResponse)
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .transition(.opacity)
                    }
                }
                .background(Color(red: 30/255, green: 40/255, blue: 50/255))
                .cornerRadius(10)
                .padding()

                HStack {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $inputText)
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(height: 100)
                            .scrollContentBackground(.hidden)
                            .background(Color(red: 30/255, green: 40/255, blue: 50/255))
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                        if inputText.isEmpty {
                            Text("Enter your question...")
                                .font(.title)
                                .foregroundColor(Color(white: 0.8))
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
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.leading)
                    }
                .padding()
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
}
#Preview {
    ChatView()

}
