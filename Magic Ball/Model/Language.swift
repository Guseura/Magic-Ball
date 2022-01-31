import UIKit

struct Language {
    
    let name: String
    let code: Code
    
    internal enum Code: String, Codable {
        case en, ua
        
        init(_ value: String) {
            switch value {
            case "en": self = .en
            case "ua": self = .ua
            default: self = .en
            }
        }
        
        public func getLanguage() -> Language {
            return (Language.languages.first { $0.code == self })!
        }
    }
    
    static let languages: [Language] = [
        Language(name: "English",   code: .en),
        Language(name: "Ukranian",  code: .ua)
        
    ]
}

/*
 //           _._
 //        .-'   `
 //      __|__
 //     /     \
 //     |()_()|
 //     \{o o}/
 //      =\o/=
 //       ^ ^
 */