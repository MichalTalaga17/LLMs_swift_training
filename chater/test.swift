import SwiftUI
import LLM

struct TestView: View {
    @State var text: String = "Hello, World!"
    var body: some View {
        VStack {
            Text(text)

            Button("Run AI") {
                Task {
                    print("Clicked!")
                    let systemPrompt = "You are a experienced ios developer."
                    let modelRef = HuggingFaceModel("unsloth/Qwen3-0.6B-GGUF", .Q4_K_M, template: .chatML(systemPrompt))
                    
                    if let bot = try? await LLM(from: modelRef) {
                        let question = bot.preprocess("Give me exaple of view in swiftui", [])
                        let answer = await bot.getCompletion(from: question)
                        print(answer)
                        text = answer
                    } else {
                        print("❌ Failed to initialize model (nil).")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    TestView()
}
