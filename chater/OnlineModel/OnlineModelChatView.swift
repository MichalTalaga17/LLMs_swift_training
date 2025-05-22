//
//  OnlineModelChatView.swift
//  chater
//
//  Created by Michał Talaga on 22/05/2025.
//


import SwiftUI
import MarkdownUI

struct OnlineModelChatView: View {
    @StateObject private var viewModel = OnlineModelChatViewModel()
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack {
            ScrollView {
                if viewModel.answerText.isEmpty {
                    ContentUnavailableView("Start your chat", systemImage: "message")
                } else {
                    Markdown(viewModel.answerText.filteredMarkdown)
                        .padding()
                }
            }

            Divider()

            VStack(alignment: .leading, spacing: 12) {
                if viewModel.isFocused {
                    HStack(spacing: 8) {
                        ForEach(viewModel.suggestions, id: \.self) { text in
                            Text(text)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color(.systemGray6))
                                .clipShape(Capsule())
                                .onTapGesture {
                                    viewModel.selectSuggestion(text)
                                }
                        }
                    }
                    .transition(.opacity)
                }

                HStack {
                    TextField("Ask anything", text: $viewModel.message)
                        .textFieldStyle(.roundedBorder)
                        .focused($isTextFieldFocused)
                        .onChange(of: isTextFieldFocused) { focused in
                            viewModel.isFocused = focused
                        }

                    Button {
                        viewModel.sendMessage()
                    } label: {
                        Image(systemName: "arrow.up")
                            .padding(8)
                            .background(viewModel.message.isEmpty ? Color.gray.opacity(0.3) : .blue)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                    }
                    .disabled(viewModel.message.isEmpty)
                }
            }
            .padding()
            .background(Color(.systemGray6))
        }
        .animation(.easeInOut, value: viewModel.isFocused)
    }
}

#Preview {
    OnlineModelChatView()
}
