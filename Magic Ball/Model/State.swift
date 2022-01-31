import Foundation

class State {

    // MARK: - Variables
    
    // Shared variable
    
    public static var shared: State = State()
    
    // MARK: - Functions
    
    public func getLanguageCode() -> Language.Code {
        let code = userDefaults.string(forKey: UDKeys.language) ?? "en"
        return Language.Code.init(code)
    }
    
    public func setLanguage(to languageCode: Language.Code) {
        userDefaults.set(languageCode.rawValue, forKey: UDKeys.language)
    }

}
