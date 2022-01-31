import Foundation

// Magic
struct Magic: Codable {
    let question, answer, type: String
}

// Response
struct MagicResponse: Codable {
    let magic: Magic
}


