//
//  OnlineModelChatView.swift
//  chater
//
//  Created by Michał Talaga on 22/05/2025.
//

import MarkdownUI
import SwiftUI

struct OnlineModelChatView: View {
    @StateObject private var viewModel = OnlineModelChatViewModel()
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            Picker("Select Model", selection: $viewModel.selectedModel) {
                ForEach(AIModel.allCases) { model in
                    Text(model.displayName).tag(model)
                }
            }
            .padding(.horizontal)
            .foregroundColor(.white)
            .accentColor(.white)
            
            ScrollView {
                if viewModel.answerText.isEmpty {
                    ContentUnavailableView("Start your chat", systemImage: "message")
                        .foregroundStyle(.white)
                } else {
                    Markdown(viewModel.answerText.filteredMarkdown)
                        .markdownTextStyle {
                            ForegroundColor(.white)
                        }
                        .padding()
                }
                
            }
            .scrollBounceBehavior(.basedOnSize)

            Spacer()

            VStack(alignment: .leading) {
                if viewModel.isFocused {
                    HStack(spacing: 8) {
                        ForEach(viewModel.suggestions, id: \.self) { text in
                            Text(text)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .onTapGesture { viewModel.selectSuggestion(text) }
                                .foregroundStyle(Color.white)
                        }
                    }
                }

                HStack {
                    TextField("", text: $viewModel.message, prompt: Text("Ask a question...").foregroundColor(.white.opacity(0.8)))
                        .foregroundStyle(Color.white)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { _, newValue in
                            viewModel.isFocused = newValue
                        }

                    Button {
                        viewModel.sendMessage()
                    } label: {
                        Image(systemName: "arrow.up")
                            .padding(8)
                            .background(viewModel.message.isEmpty ? Color.white.opacity(0.1) : .white)
                            .foregroundColor(viewModel.message.isEmpty ? .white : .black)
                            .clipShape(Circle())
                    }
                    .disabled(viewModel.message.isEmpty)
                }
                .padding()
                .background(Color.white.opacity(0.1))
            }
        }
        .background(Color(red: 0.11, green: 0.11, blue: 0.11))
        // .animation(.easeInOut, value: viewModel.isFocused)
    }
}

#Preview {
    OnlineModelChatView()
}
