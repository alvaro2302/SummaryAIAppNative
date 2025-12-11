//
//  TranscriptRecordResponse.swift
//  SummaryApp
//
//  Created by Alvaro Cuiza on 11/12/25.
//
import Foundation
struct TranscriptRecordResponse: Codable {
    let id, languageModel, acousticModel: String
    let languageCode, speechUnderstanding, translatedTexts: JSONNull?
    let status: String
    let audioURL: String
    let text, words, utterances, confidence: JSONNull?
    let audioDuration: JSONNull?
    let punctuate, formatText: Bool
    let webhookURL, webhookStatusCode: JSONNull?
    let webhookAuth: Bool
    let webhookAuthHeaderName: JSONNull?
    let speedBoost: Bool
    let autoHighlightsResult: JSONNull?
    let autoHighlights: Bool
    let audioStartFrom, audioEndAt: JSONNull?
    let wordBoost: [JSONAny]
    let boostParam, prompt, keytermsPrompt: JSONNull?
    let filterProfanity, redactPii, redactPiiAudio: Bool
    let redactPiiAudioQuality, redactPiiAudioOptions, redactPiiPolicies, redactPiiSub: JSONNull?
    let speakerLabels: Bool
    let speakerOptions: JSONNull?
    let contentSafety, iabCategories: Bool
    let contentSafetyLabels, iabCategoriesResult: ContentSafetyLabels
    let languageDetection: Bool
    let languageDetectionOptions, languageDetectionResults, languageConfidenceThreshold, languageConfidence: JSONNull?
    let customSpelling: JSONNull?
    let throttled, autoChapters, summarization: Bool
    let summaryType, summaryModel: JSONNull?
    let customTopics: Bool
    let topics: [JSONAny]
    let speechThreshold, speechModel: JSONNull?
    let speechModels: [String]
    let speechModelUsed, chapters: JSONNull?
    let disfluencies, entityDetection, sentimentAnalysis: Bool
    let sentimentAnalysisResults, entities, speakersExpected, summary: JSONNull?
    let customTopicsResults, isDeleted, multichannel: JSONNull?
    let projectID, tokenID: Int

    enum CodingKeys: String, CodingKey {
        case id
        case languageModel = "language_model"
        case acousticModel = "acoustic_model"
        case languageCode = "language_code"
        case speechUnderstanding = "speech_understanding"
        case translatedTexts = "translated_texts"
        case status
        case audioURL = "audio_url"
        case text, words, utterances, confidence
        case audioDuration = "audio_duration"
        case punctuate
        case formatText = "format_text"
        case webhookURL = "webhook_url"
        case webhookStatusCode = "webhook_status_code"
        case webhookAuth = "webhook_auth"
        case webhookAuthHeaderName = "webhook_auth_header_name"
        case speedBoost = "speed_boost"
        case autoHighlightsResult = "auto_highlights_result"
        case autoHighlights = "auto_highlights"
        case audioStartFrom = "audio_start_from"
        case audioEndAt = "audio_end_at"
        case wordBoost = "word_boost"
        case boostParam = "boost_param"
        case prompt
        case keytermsPrompt = "keyterms_prompt"
        case filterProfanity = "filter_profanity"
        case redactPii = "redact_pii"
        case redactPiiAudio = "redact_pii_audio"
        case redactPiiAudioQuality = "redact_pii_audio_quality"
        case redactPiiAudioOptions = "redact_pii_audio_options"
        case redactPiiPolicies = "redact_pii_policies"
        case redactPiiSub = "redact_pii_sub"
        case speakerLabels = "speaker_labels"
        case speakerOptions = "speaker_options"
        case contentSafety = "content_safety"
        case iabCategories = "iab_categories"
        case contentSafetyLabels = "content_safety_labels"
        case iabCategoriesResult = "iab_categories_result"
        case languageDetection = "language_detection"
        case languageDetectionOptions = "language_detection_options"
        case languageDetectionResults = "language_detection_results"
        case languageConfidenceThreshold = "language_confidence_threshold"
        case languageConfidence = "language_confidence"
        case customSpelling = "custom_spelling"
        case throttled
        case autoChapters = "auto_chapters"
        case summarization
        case summaryType = "summary_type"
        case summaryModel = "summary_model"
        case customTopics = "custom_topics"
        case topics
        case speechThreshold = "speech_threshold"
        case speechModel = "speech_model"
        case speechModels = "speech_models"
        case speechModelUsed = "speech_model_used"
        case chapters, disfluencies
        case entityDetection = "entity_detection"
        case sentimentAnalysis = "sentiment_analysis"
        case sentimentAnalysisResults = "sentiment_analysis_results"
        case entities
        case speakersExpected = "speakers_expected"
        case summary
        case customTopicsResults = "custom_topics_results"
        case isDeleted = "is_deleted"
        case multichannel
        case projectID = "project_id"
        case tokenID = "token_id"
    }
}

// MARK: - ContentSafetyLabels
struct ContentSafetyLabels: Codable {
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}
