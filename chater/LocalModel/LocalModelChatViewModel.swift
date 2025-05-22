//
//  LocalModelChatViewModel.swift
//  chater
//
//  Created by Michał Talaga on 22/05/2025.
//



import Foundation
import LLM
import SwiftUI



@MainActor
class LocalModelChatViewModel: ObservableObject {
    @Published var answerText: String = ""
    @Published var message: String = ""
    @Published var isFocused: Bool = false

    let suggestions = [
        "Write advanced SwiftUI view",
        "Recommend the best comedy show",
        "Top video games of 2025"
    ]

    func selectSuggestion(_ text: String) {
        message = text
        isFocused = false
    }

    func sendMessage() {
        Task {
            let question: String = message
            message = ""
            let systemPrompt = "You are kind and helpful."
            let modelRef = HuggingFaceModel("unsloth/Qwen3-0.6B-GGUF", .Q4_K_M, template: .chatML(systemPrompt))

            guard let bot = try? await LLM(from: modelRef) else {
                answerText = "FAILED TO INITIALIZE MODEL"
                return
            }
            _ = bot.preprocess(question, [])
            answerText = ""

            await bot.respond(to: question) { stream in
                var fullAnswer = ""
                for await token in stream {
                    fullAnswer += token
                    self.answerText = fullAnswer
                }
                return fullAnswer
            }
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
