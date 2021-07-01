import Foundation

protocol NetworkRequest {
    func request<T: Codable>(route: NetworkRouter, keyTask: String, completion: @escaping (Result<T, DescriptionError>) -> ())
    func cancelTask(keyTask: String)
}

extension NetworkRequest {
    func request<T: Codable>(route: NetworkRouter, keyTask: String = "", completion: @escaping (Result<T, DescriptionError>) -> ()) {
        request(route: route, keyTask: keyTask, completion: completion)
    }
}

class NetworkManager: NetworkRequest {
    private let baseUrl: String
    private var tasks = [String: URLSessionTask]()
    init (baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func request<T: Codable>(route: NetworkRouter, keyTask: String, completion: @escaping (Result<T, DescriptionError>) -> ()) {
        var components = URLComponents(string: baseUrl + route.path)
        components?.queryItems = route.query
        guard let url = components?.url else {
            completion(.failure(.init(description: "Url error")))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = route.method
        request.httpBody = route.body
        
        request.allHTTPHeaderFields = route.headers.compactMapValues{$0 as? String}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.init(description: NetworkResponse.disconect.rawValue)))
                }
                return
            }
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.init(description: NetworkResponse.failed.rawValue)))
                }
                return
            }
            print("Status \(response.statusCode): \(url.absoluteString)")
            let responseStatus = self.handleNetworkResponse(response)
            switch responseStatus {
            case .success:
                DispatchQueue.main.async {
                    completion(CodableService.decode(data: data))
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(.init(description: responseStatus.rawValue)))
                }
            }
        }
        if !keyTask.isEmpty {
            tasks[keyTask] = task
        }
        task.resume()
    }
    
    func cancelTask(keyTask: String) {
        tasks[keyTask]?.cancel()
        tasks[keyTask] = nil
    }
    
    private func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResponse {
        switch response.statusCode {
        case 200...299:
            return .success
        case 400...499:
            return .authenticationError
        case 500...599:
            return .badRequest
        case 600:
            return .outdated
        default:
            return .failed
        }
    }
}

enum NetworkResponse: String {
    case success
    case authenticationError = "Need authentication"
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case disconect = "Plase check your network connection"
}

protocol NetworkRouter {
    var path: String {get}
    var headers: [String: Any] {get}
    var method: String {get}
    var body: Data? {get}
    var query: [URLQueryItem] {get}
}
