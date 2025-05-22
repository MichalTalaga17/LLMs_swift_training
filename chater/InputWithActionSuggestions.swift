
import SwiftUI
import LLM
import MarkdownUI

struct InputWithActionSuggestions: View {
    @State private var answerText: String = ""
    @State private var message: String = ""
    @FocusState private var isFocused: Bool
    
    let suggestions = [
        "Write advanced SwiftUI view",
        "Recommend the best comedy show",
        "Top video games of 2025"
    ]
    
    var body: some View {
        VStack {
            ScrollView {
                if answerText.isEmpty {
                    ContentUnavailableView("Start your chat", systemImage: "message")
                } else {
                    Markdown(answerText.filteredMarkdown)
                        .padding()
                }
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 12) {
                if isFocused {
                    HStack(spacing: 8) {
                        ForEach(suggestions, id: \.self) { text in
                            Text(text)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray6))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    message = text
                                    isFocused = false
                                }
                        }
                    }
                    .transition(.opacity)
                }
                
                HStack {
                    TextField("Ask anything", text: $message)
                        .textFieldStyle(.roundedBorder)
                        .focused($isFocused)
                    
                    Button {
                        sendMessage()
                    } label: {
                        Image(systemName: "arrow.up")
                            .padding(8)
                            .background(message.isEmpty ? Color.gray.opacity(0.3) : .blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .disabled(message.isEmpty)
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .animation(.easeInOut, value: isFocused)
    }
    
    private func sendMessage() {
        Task {
            print("Clicked")
            let systemPrompt = "You are kind and helpful."
            let modelRef = HuggingFaceModel("unsloth/Qwen3-0.6B-GGUF", .Q4_K_M, template: .chatML(systemPrompt))
            
            if let bot = try? await LLM(from: modelRef) {
                let question = bot.preprocess(message, [])
                let answer = await bot.getCompletion(from: question)
                answerText = answer
                print(answer)
            } else {
                answerText = "❌ Failed to initialize model."
            }
            message = ""
            isFocused = false
        }
    }
}

extension String {
    var filteredMarkdown: String {
        let pattern = #"<think>[\s\S]*?<\/think>"#
        return self.replacingOccurrences(of: pattern, with: "", options: .regularExpression)
    }
}


#Preview {
    InputWithActionSuggestions()
}
