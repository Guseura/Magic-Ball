import Foundation

class State {

    // MARK: - Variables
    
    // Shared variable
    
    public static var shared: State = State()
    
    public var userAnswers: [String] = []
    public var answers: [String] = [
        "My reply is no",
        "It is certain",
        "Outlook good",
        "Don`t count on it",
        "Reply hazy, try again",
        "Better not tell you now",
        "My sources say no",
        "Without a doubt",
        "Yes",
        "Ask again later",
        "Cannot predict now"
        
    ]
    
    // MARK: - Functions
    
    public func getAllAnswers() -> [String] {
        var allAnswers = userDefaults.stringArray(forKey: UDKeys.userAnswers) ?? []
        for answer in answers {
            if !allAnswers.contains(answer) {
                allAnswers.append(answer)
            }
        }
        return allAnswers
    }
    
    public func getUserAnswers() -> [String] {
        return userDefaults.stringArray(forKey: UDKeys.userAnswers) ?? []
    }
    
    public func appendToUserAnswers(answer: String) {
        userAnswers = userDefaults.stringArray(forKey: UDKeys.userAnswers) ?? []
        if !userAnswers.contains(answer) {
            userAnswers.append(answer)
            userDefaults.set(userAnswers, forKey: UDKeys.userAnswers)
        }
    }
    
    public func getLanguageCode() -> Language.Code {
        let code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
    }

}
