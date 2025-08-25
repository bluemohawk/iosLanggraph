import SwiftUI

// This code replicates the chat interface from the provided HTML.
// It uses standard SwiftUI views, colors, and SF Symbols to create a native feel
// without relying on custom fonts or extensions.

struct secondView: View {
    var body: some View {
        ZStack {
            // Background color
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // MARK: - Header
                // Replicates the sticky, translucent header with blur effect
                ZStack {
                    Color(red: 28/255, green: 28/255, blue: 30/255)
                        .opacity(0.8)
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea(.all, edges: .top)
                    
                    HStack {
                        // Back button
                        Button(action: {
                            // Action for back button
                        }) {
                            HStack(spacing: 4) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .semibold))
                                Text("Back")
                            }
                        }
                        .foregroundColor(Color(red: 10/255, green: 132/255, blue: 255/255))
                        
                        Spacer()
                        
                        // Title
                        Text("AI Assistant")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Spacer for alignment
                        Color.clear.frame(width: 64, height: 1)
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 56) // Matches h-14 (14 * 4 = 56)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                // MARK: - Main Content (Chat Bubbles)
                // Replicates the scrollable chat history
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        // AI Message
                        HStack(alignment: .bottom, spacing: 8) {
                            // Placeholder for avatar. In a real app, this would be an AsyncImage.
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 28, height: 28)
                                .foregroundColor(Color.gray)
                            
                            VStack(alignment: .leading) {
                                Text("Hello! How can I assist you today?")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 14)
                                    .background(Color(red: 44/255, green: 44/255, blue: 46/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(20, corners: [.topRight, .bottomRight, .bottomLeft])
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            // Pushes the bubble to the left
                            Spacer()
                        }
                        
                        // User Message
                        HStack(alignment: .bottom, spacing: 8) {
                            // Pushes the bubble to the right
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Hi! I need help with my account.")
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 14)
                                    .background(Color(red: 10/255, green: 132/255, blue: 255/255))
                                    .foregroundColor(.white)
                                    .cornerRadius(20, corners: [.topLeft, .bottomLeft, .bottomRight])
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                        }
                    }
                    .padding(.top, 24)
                    .padding(.bottom, 16)
                    .padding(.horizontal, 16)
                }
                
                // MARK: - Footer (Input Field)
                // Replicates the sticky, translucent footer with blur effect
                ZStack {
                    Color(red: 28/255, green: 28/255, blue: 30/255)
                        .opacity(0.8)
                        .background(.ultraThinMaterial)
                        .ignoresSafeArea(.all, edges: .bottom)
                    
                    HStack(spacing: 8) {
                        // Text input field
                        TextField("Type a message...", text: .constant(""))
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color(red: 44/255, green: 44/255, blue: 46/255))
                            .foregroundColor(.white)
                            .cornerRadius(.infinity)
                            .overlay(
                                RoundedRectangle(cornerRadius: .infinity)
                                    .stroke(Color.clear, lineWidth: 0)
                            )
                        
                        // Send button
                        Button(action: {
                            // Action to send message
                        }) {
                            Image(systemName: "arrow.up")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Color(red: 10/255, green: 132/255, blue: 255/255))
                                .cornerRadius(.infinity)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}

// A helper struct for rounded corners on specific sides
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

#Preview {
    secondView()

}

