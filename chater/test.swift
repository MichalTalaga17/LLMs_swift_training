import LLM
import SwiftUI
import MarkdownUI

struct TestView: View {
    @State var text: String = "Hello, World!"

    var body: some View {
        VStack {
            ScrollView {
                Markdown(text)
            }

            Button("Run AI") {
                Task {
                    let systemPrompt = "You are an experienced iOS developer."
                    print("\n----------PREPARING MODEL WITH SYSTEM PROMPT----------\n \(systemPrompt)")

                    let modelRef = HuggingFaceModel("unsloth/Qwen3-0.6B-GGUF", .Q4_K_M, template: .chatML(systemPrompt))
                    print("\n----------MODEL REFERENCE CREATED----------\n \(modelRef)")

                    do {
                        print("\n----------INITIALIZING MODEL...----------\n")
                        if let bot = try await LLM(from: modelRef) {
                            print("\n----------MODEL INITIALIZED SUCCESSFULLY----------\n")

                            let questionText = "Give me example of view in SwiftUI"
                            print("\n----------PREPROCESSING QUESTION----------\n \(questionText)")

                            let question = bot.preprocess(questionText, [])
                            print("\n----------PREPROCESSED QUESTION READY----------\n \(question)")

                            print("\n----------REQUESTING COMPLETION FROM MODEL...----------\n")
                            let answer = await bot.getCompletion(from: question)

                            print("\n----------RECEIVED ANSWER----------\n")
                            print(answer)

                            DispatchQueue.main.async {
                                text = answer
                                print("\n----------TEXT UPDATED WITH MODEL ANSWER----------\n")
                            }
                        } else {
                            print("\n----------FAILED TO INITIALIZE MODEL (NIL)----------\n")
                        }
                    } catch {
                        print("ERROR DURING MODEL INITIALIZATION OR REQUEST----------\n \(error.localizedDescription)")
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

