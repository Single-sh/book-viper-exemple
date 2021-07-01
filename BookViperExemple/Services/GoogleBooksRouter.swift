import Foundation

enum GoogleBooksRouter: NetworkRouter {
    case getList(search: String)
    
    var path: String {
        switch self {
        case .getList(_):
            return "/volumes"
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
