import Foundation

protocol NetworkRequest {
    func request<T: Codable>(link: LinkRequest, completion: @escaping (Result<T, DescriptionError>) -> ())
}

class NetworkManager: NetworkRequest {
    private let baseUrl: String
    private var tasks = [URLSessionTask]()
    init (baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func request<T: Codable>(link: LinkRequest, completion: @escaping (Result<T, DescriptionError>) -> ()) {
        var components = URLComponents(string: baseUrl + link.path)
        components?.queryItems = link.query
        guard let url = components?.url else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = link.method
        request.httpBody = link.body
        
        request.allHTTPHeaderFields = link.headers.compactMapValues{$0 as? String}
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let respons = response as? HTTPURLResponse else {
                completion(.failure(.init(description: "response is Empty")))
                return
            }
            print("Status \(respons.statusCode): \(url.absoluteString)")
            switch respons.statusCode {
            case 200...299:
                DispatchQueue.main.async { [unowned self] in
                    completion(self.decode(data: data))
                }
            case 400...499:
                DispatchQueue.main.async {
                    completion(.failure(.init(description: "Bad request")))
                }
            case 500...599:
                DispatchQueue.main.async {
                    completion(.failure(.init(description: "Server dont response")))
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(.init(description: "Unowned status code")))
                }
            }
        }
        tasks.append(task)
        task.resume()
    }
    
    private func printStatusRequest(status: Int, url: URL) {
        print("Status \(status): \(url.absoluteString)")
    }
    
    private func decode<T: Decodable>(data: Data?) -> Result<T, DescriptionError> {
        do {
            let result = try JSONDecoder().decode(T.self, from: data ?? Data())
            return .success(result)
            
        }
        catch {
            print(error)
            return .failure(.init(description: "Error decoder jsson"))
        }
    }
}


protocol LinkRequest {
    var path: String {get}
    var headers: [String: Any] {get}
    var method: String {get}
    var body: Data? {get}
    var query: [URLQueryItem] {get}
}

enum LinkList: LinkRequest {
    case getList(search: String)
    
    var path: String {
        switch self {
        case let .getList(search):
            return "/volumes?q=\(search)"
        }
    }
    
    var headers: [String : Any] {
        let headers: [String: Any] = ["Content-type": "application/json"]
        return headers
    }
    
    var query: [URLQueryItem] {
        switch self {
        case let .getList(search):
            return [URLQueryItem(name: "q", value: search)]
        }
    }
    
    var method: String {
        switch self {
        case .getList(_):
            return "GET"
        }
    }
    
    var body: Data? {
        nil
    }
    
}

struct ErrorRequest: Error {
    let message: String
}
