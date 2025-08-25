import SwiftUI

struct frontView: View {
    var body: some View {
        ZStack {
            // Background color using a standard Color initializer
            Color(red: 17/255, green: 25/255, blue: 34/255)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer() // Pushes content to the center
                
                VStack(spacing: 20) {
                    // Chat icon using SF Symbols
                    Image(systemName: "bubble.left.and.bubble.right.fill")
                        .font(.system(size: 80))
                        .foregroundColor(Color.blue) // Using a standard color
                        .padding(.bottom, 10)
                    
                    // Welcome title using standard SwiftUI font modifiers
                    Text("Welcome to Morning Live")
                        .font(.system(size: 36, weight: .bold))
                        .foregroundColor(Color.white)
                        .multilineTextAlignment(.center)
                        .lineSpacing(4)
                        .padding(.horizontal)
                    
                    // Subtitle text
                    Text("Connect with friends and family instantly. Your conversations, your space.")
                        .font(.body)
                        .foregroundColor(Color(red: 160/255, green: 174/255, blue: 192/255))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                }
                .padding(.bottom, 50)
                
                Spacer() // Pushes content to the center
                
                // Start Chatting Button
                Button(action: {
                    // Action for the button goes here
                }) {
                    HStack {
                        Text("Start Chatting")
                            .font(.body.bold())
                            .lineLimit(1)
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 20))
                    }
                    .frame(height: 56)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 24)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(12)
                    .shadow(color: Color.blue.opacity(0.4), radius: 10, x: 0, y: 5)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 30)
            }
        }
    }
}

#Preview {
    frontView()

}

