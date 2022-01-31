import Foundation

enum APIError: String, Error {
    case invalidData = "The data received from the server is invalid. Please try again"
    case decodingProblem
    case encodingProblem
    case invalidURL
    case unableToComplete = "Unable to completed your request. Please check your internet connection."
}

private let magicBaseURL = "https://8ball.delegator.com/magic/JSON/"

struct MagicNetwork {
    
    func getMagic(with question: String = "magic", completion: @escaping (Result<MagicResponse, APIError>) -> Void) {
        
        let modifiedQuestion = question.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let urlString = magicBaseURL + (modifiedQuestion ?? "magic")
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(MagicResponse.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.decodingProblem))
            }
            
        }.resume()
        
    }
    
}
