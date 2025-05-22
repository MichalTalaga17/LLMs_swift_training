//
//  OnlineModelChatViewModel.swift
//  chater
//
//  Created by Michał Talaga on 22/05/2025.
//


import Foundation
import SwiftUI

@MainActor
class OnlineModelChatViewModel: ObservableObject {
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
        let userMessage = message
        answerText = ""
        message = ""
        isFocused = false

        Task {
            guard let url = URL(string: "https://openrouter.ai/api/v1/chat/completions") else {
                answerText = "❌ Invalid API URL"
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer YOUR_API_KEY_HERE", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("https://yourapp.example.com", forHTTPHeaderField: "HTTP-Referer")
            request.setValue("Your App Name", forHTTPHeaderField: "X-Title")

            let payload: [String: Any] = [
                "model": "deepseek/deepseek-chat-v3-0324:free",
                "messages": [
                    ["role": "user", "content": userMessage]
                ]
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: payload)
            } catch {
                answerText = "❌ Failed to encode request"
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decoded = try JSONDecoder().decode(OpenRouterResponse.self, from: data)
                if let content = decoded.choices.first?.message.content {
                    answerText = content
                } else {
                    answerText = "❌ No content in response"
                }
            } catch {
                answerText = "❌ Request failed: \(error.localizedDescription)"
            }
        }
    }
}

struct OpenRouterResponse: Codable {
    struct Choice: Codable {
        struct Message: Codable {
            let role: String
            let content: String
        }
        let message: Message
    }
    let choices: [Choice]
}

