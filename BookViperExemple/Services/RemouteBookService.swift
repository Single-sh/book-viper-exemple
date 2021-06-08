import Foundation
import Moya

enum RemouteBookService {
    case getList(search: String)
}

extension RemouteBookService: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.googleapis.com/books/v1")!
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/volumes"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
            case let .getList(search):
                return .requestParameters(
                    parameters: [
                        "q": search,
                        "maxResults": 5
                    ],
                    encoding: URLEncoding.queryString)
            }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    var validationType: ValidationType {
        .successCodes
    }
    
}
