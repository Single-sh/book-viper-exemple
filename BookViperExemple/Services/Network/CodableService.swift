import Foundation

enum CodableService {
    static func decode<T: Decodable>(data: Data?) -> Result<T, DescriptionError> {
        if data == nil {
            return .failure(.init(description: NetworkResponse.noData.rawValue))
        }
        do {
            let result = try JSONDecoder().decode(T.self, from: data ?? Data())
            return .success(result)
        }
        catch {
            print(error)
            return .failure(.init(description: NetworkResponse.unableToDecode.rawValue))
        }
    }
}
