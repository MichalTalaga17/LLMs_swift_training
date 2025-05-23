//
//  ModelsList.swift
//  chater
//
//  Created by Michał Talaga on 23/05/2025.
//

import Foundation

enum AIModel: String, CaseIterable, Identifiable {
    case llama32_11b_vision
    case deepseek_v3_0324
    case deepseek_R1
    case qwen25_72b_instruct
    case qwen25_vl_7b
    case llama31_405b_base
    case llama31_8b_instruct
    case mistral_nemo
    case gemma_2_9b
    case mistral_7b_instruct
    case llama3_8b_instruct
    case google_gemini_20_flash
    case llama4_scout
    case deepseek_prover_v2

    var id: String { rawValue }

    var displayName: String {
        switch self {
            case .llama32_11b_vision: return "LLaMA 3.2 11B Vision"
            case .deepseek_v3_0324: return "DeepSeek v3.0324"
            case .deepseek_R1: return "DeepSeek R1"
            case .qwen25_72b_instruct: return "Qwen2.5 72B Instruct"
            case .qwen25_vl_7b: return "Qwen2.5 VL 7B Instruct"
            case .llama31_405b_base: return "LLaMA 3.1 405B (Base)"
            case .llama31_8b_instruct: return "LLaMA 3.1 8B Instruct"
            case .mistral_nemo: return "Mistral Nemo"
            case .gemma_2_9b: return "Gemma 2 9B"
            case .mistral_7b_instruct: return "Mistral 7B Instruct"
            case .llama3_8b_instruct: return "LLaMA 3 8B Instruct"
            case .google_gemini_20_flash: return "Google Gemini 2.0 Flash"
            case .llama4_scout: return "LLaMA 4 Scout"
            case .deepseek_prover_v2: return "DeepSeek Prover V2"
        }
    }

    var modelID: String {
        switch self {
            case .llama32_11b_vision: return "meta-llama/llama-3.2-11b-vision-instruct:free"
            case .deepseek_v3_0324: return "deepseek/deepseek-chat-v3-0324:free"
            case .deepseek_R1: return "deepseek/deepseek-r1:free"
            case .qwen25_72b_instruct: return "qwen/qwen2.5-vl-72b-instruct:free"
            case .qwen25_vl_7b: return "qwen/qwen-2.5-vl-7b-instruct:free"
            case .llama31_405b_base: return "meta-llama/llama-3.1-405b:free"
            case .llama31_8b_instruct: return "meta-llama/llama-3.1-8b-instruct:free"
            case .mistral_nemo: return "mistralai/mistral-nemo:free"
            case .gemma_2_9b: return "google/gemma-2-9b-it:free"
            case .mistral_7b_instruct: return "mistralai/mistral-7b-instruct:free"
            case .llama3_8b_instruct: return "meta-llama/llama-3.3-8b-instruct:free"
            case .google_gemini_20_flash: return "google/gemini-2.0-flash-exp:free"
            case .llama4_scout: return "meta-llama/llama-4-scout:free"
            case .deepseek_prover_v2: return "deepseek/deepseek-prover-v2:free"
        }
    }

    var description: String {
        switch self {
            case .llama32_11b_vision: return "Multimodal model for visual reasoning and VQA."
            case .deepseek_v3_0324: return "Ideal for creative writing, coding assistance, and general Q&A."
            case .deepseek_R1: return "Fast and accurate language model for general Q&A."
            case .qwen25_72b_instruct: return "Massive instruction model with strong coding/math skills."
            case .qwen25_vl_7b: return "Video/image understanding model with multilingual support."
            case .llama31_405b_base: return "Huge base model with strong human eval scores."
            case .llama31_8b_instruct: return "Fast general-purpose instruct model."
            case .mistral_nemo: return "Multilingual 12B model with 128K context."
            case .gemma_2_9b: return "Google open-source model, fast and safe."
            case .mistral_7b_instruct: return "Efficient 7B instruction model."
            case .llama3_8b_instruct: return "Updated LLaMA 3 instruct model."
            case .google_gemini_20_flash: return "Fast and efficient language model for general Q&A."
            case .llama4_scout: return "Large language model for general text completion and reasoning."
            case .deepseek_prover_v2: return "Proven model for logical reasoning and coding assistance."
        }
    }

    var contextLength: String {
        switch self {
            case .llama32_11b_vision, .llama31_8b_instruct, .mistral_nemo:  return "131K"
            case .qwen25_72b_instruct: return "128K"
            case .qwen25_vl_7b, .mistral_7b_instruct: return "33K"
            case .llama31_405b_base: return "64K"
            case .gemma_2_9b: return "8K"
            case .llama3_8b_instruct: return "8K"
            case .deepseek_v3_0324: return "32K"
            case .deepseek_R1: return "164K"
            case .google_gemini_20_flash: return "1M"
            case .llama4_scout: return "200K"
            case .deepseek_prover_v2: return "164K"
        }
    }
}
