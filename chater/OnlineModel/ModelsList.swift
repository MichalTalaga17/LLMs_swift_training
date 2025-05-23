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
    case qwen25_72b_instruct
    case qwen25_vl_7b
    case llama31_405b_base
    case llama31_8b_instruct
    case mistral_nemo
    case gemma_2_9b
    case mistral_7b_instruct
    case mixtral_8x22b
    case llama3_8b_instruct
    case openchat_7b
    case mancer_7b_32k
    case noromaid_20b
    case mythomax_l2_13b
    case openhermes_25_mistral

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .llama32_11b_vision: return "LLaMA 3.2 11B Vision"
        case .deepseek_v3_0324: return "DeepSeek v3.0324"
        case .qwen25_72b_instruct: return "Qwen2.5 72B Instruct"
        case .qwen25_vl_7b: return "Qwen2.5 VL 7B Instruct"
        case .llama31_405b_base: return "LLaMA 3.1 405B (Base)"
        case .llama31_8b_instruct: return "LLaMA 3.1 8B Instruct"
        case .mistral_nemo: return "Mistral Nemo"
        case .gemma_2_9b: return "Gemma 2 9B"
        case .mistral_7b_instruct: return "Mistral 7B Instruct"
        case .mixtral_8x22b: return "Mixtral 8x22B"
        case .llama3_8b_instruct: return "LLaMA 3 8B Instruct"
        case .openchat_7b: return "OpenChat 7B"
        case .mancer_7b_32k: return "Mancer 7B 32K"
        case .noromaid_20b: return "Noromaid 20B"
        case .mythomax_l2_13b: return "MythoMax L2 13B"
        case .openhermes_25_mistral: return "OpenHermes 2.5 Mistral"
        }
    }

    var modelID: String {
        switch self {
        case .llama32_11b_vision: return "meta-llama/llama-3.2-11b-vision-instruct:free"
        case .deepseek_v3_0324: return "deepseek/deepseek-v3.0324:free"
        case .qwen25_72b_instruct: return "qwen/qwen2.5-72b-instruct:free"
        case .qwen25_vl_7b: return "qwen/qwen2.5-vl-7b-instruct:free"
        case .llama31_405b_base: return "meta-llama/llama-3.1-405b-base:free"
        case .llama31_8b_instruct: return "meta-llama/llama-3.1-8b-instruct:free"
        case .mistral_nemo: return "mistralai/mistral-nemo:free"
        case .gemma_2_9b: return "google/gemma-2-9b:free"
        case .mistral_7b_instruct: return "mistralai/mistral-7b-instruct:free"
        case .mixtral_8x22b: return "mistralai/mixtral-8x22b:free"
        case .llama3_8b_instruct: return "meta-llama/llama-3-8b-instruct:free"
        case .openchat_7b: return "openchat/openchat-7b:free"
        case .mancer_7b_32k: return "mancer/mancer-7b-32k:free"
        case .noromaid_20b: return "neversleep/noromaid-20b:free"
        case .mythomax_l2_13b: return "gryphe/mytho-max-l2-13b:free"
        case .openhermes_25_mistral: return "openhermes/openhermes-2.5-mistral-7b:free"
        }
    }

    var description: String {
        switch self {
        case .llama32_11b_vision: return "Multimodal model for visual reasoning and VQA."
        case .deepseek_v3_0324: return "Ideal for creative writing, coding assistance, and general Q&A."
        case .qwen25_72b_instruct: return "Massive instruction model with strong coding/math skills."
        case .qwen25_vl_7b: return "Video/image understanding model with multilingual support."
        case .llama31_405b_base: return "Huge base model with strong human eval scores."
        case .llama31_8b_instruct: return "Fast general-purpose instruct model."
        case .mistral_nemo: return "Multilingual 12B model with 128K context."
        case .gemma_2_9b: return "Google open-source model, fast and safe."
        case .mistral_7b_instruct: return "Efficient 7B instruction model."
        case .mixtral_8x22b: return "Mixture-of-Experts model with high accuracy."
        case .llama3_8b_instruct: return "Updated LLaMA 3 instruct model."
        case .openchat_7b: return "Chat-focused conversational model."
        case .mancer_7b_32k: return "Reasoning-oriented 7B with long context."
        case .noromaid_20b: return "Balanced 20B model for productivity and creativity."
        case .mythomax_l2_13b: return "Great for RP, stories, and character dialogue."
        case .openhermes_25_mistral: return "Code + dialogue instruct model based on Mistral."
        }
    }

    var contextLength: String {
        switch self {
        case .llama32_11b_vision, .llama31_8b_instruct, .mistral_nemo:
            return "131K"
        case .qwen25_72b_instruct:
            return "128K"
        case .qwen25_vl_7b, .mistral_7b_instruct:
            return "33K"
        case .llama31_405b_base:
            return "64K"
        case .gemma_2_9b:
            return "8K"
        case .mixtral_8x22b:
            return "65K"
        case .llama3_8b_instruct:
            return "8K"
        case .openchat_7b, .mancer_7b_32k, .openhermes_25_mistral, .deepseek_v3_0324:
            return "32K"
        case .noromaid_20b, .mythomax_l2_13b:
            return "16K"
        }
    }
}

