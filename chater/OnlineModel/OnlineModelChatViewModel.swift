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
    @Published var selectedModel: AIModel = .llama32_11b_vision
    
    let suggestions = [
        "Why sky is blue?",
        "Recommend the best comedy show",
        "Top video games of 2025"
    ]

    func selectSuggestion(_ text: String) {
        message = text
        isFocused = false
    }

    func sendMessage() {
        let userMessage = message
        print("[sendMessage] Starting message send. User message: \(userMessage)")
        
        answerText = ""
        message = ""
        isFocused = false

        Task {
            guard let url = URL(string: "https://openrouter.ai/api/v1/chat/completions") else {
                answerText = "Invalid API URL"
                print("[sendMessage] ERROR: Invalid API URL")
                return
            }

            guard let apiKey = Bundle.main.infoDictionary?["OPENROUTER_API_KEY"] as? String, !apiKey.isEmpty else {
                answerText = "Missing API Key"
                print("[sendMessage] ERROR: Missing API Key")
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("Chater App", forHTTPHeaderField: "X-Title")

            let payload: [String: Any] = [
                "model": selectedModel.modelID,
                "messages": [
                    ["role": "user", "content": userMessage],
                    //["role": "system", "content": "The length of the response cannot exceed 100 characters"]
                ],
                "stream": true
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: payload)
                print("[sendMessage] Payload encoded successfully: \(payload)")
            } catch {
                answerText = "Failed to encode request"
                print("[sendMessage] ERROR: Failed to encode request - \(error.localizedDescription)")
                return
            }

            do {
                print("[sendMessage] Sending request to \(url)...")
                let (stream, response) = try await URLSession.shared.bytes(for: request)
                print("[sendMessage] Response received: \(response)")
                
                var buffer = Data()
                for try await byte in stream {
                    buffer.append(byte)
                    while let range = buffer.range(of: Data("\n".utf8)) {
                        let lineData = buffer.subdata(in: buffer.startIndex..<range.lowerBound)
                        buffer.removeSubrange(buffer.startIndex...range.lowerBound)

                        if let line = String(data: lineData, encoding: .utf8) {
                            let trimmed = line.trimmingCharacters(in: .whitespacesAndNewlines)
                            if !trimmed.isEmpty, trimmed.hasPrefix("data:") {
                                let jsonString = trimmed.dropFirst(5).trimmingCharacters(in: .whitespaces)
                                print("[sendMessage] Received line: \(jsonString)")

                                if jsonString == "[DONE]" {
                                    print("[sendMessage] Stream ended with [DONE]")
                                    break
                                }

                                if let jsonData = jsonString.data(using: .utf8),
                                   let chunk = try? JSONDecoder().decode(OpenRouterStreamResponse.self, from: jsonData) {
                                    if let delta = chunk.choices.first?.delta.content {
                                        print("[sendMessage] Received delta: \(delta)")
                                        answerText += delta
                                    }
                                } else {
                                    print("[sendMessage] WARNING: Failed to decode chunk: \(jsonString)")
                                }
                            }
                        }
                    }
                }
                print("[sendMessage] Streaming completed successfully.")
            } catch {
                answerText = "Request failed: \(error.localizedDescription)"
                print("[sendMessage] ERROR: Request failed - \(error.localizedDescription)")
            }
        }
    }

}
struct OpenRouterStreamResponse: Codable {
    struct Choice: Codable {
        struct Delta: Codable {
            let content: String?
        }
        let delta: Delta
    }
    let choices: [Choice]
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
