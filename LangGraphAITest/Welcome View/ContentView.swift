//
//  ContentView.swift
//  apiTest
//
//  Created by Francois Everhard Air on 8/4/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showChatView = false

    var body: some View {
        if showChatView {
            ChatView()
        } else {
            WelcomeView(showChatView: $showChatView)
        }
    }
}

#Preview {
    ContentView()
}
