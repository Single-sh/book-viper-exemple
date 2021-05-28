import Foundation

struct ListBooks: Codable {
    let total: Int
    let items: [Book]
    
    enum CodingKeys: String, CodingKey {
        case total = "totalItems"
        case items = "items"
    }
}

struct Book: Codable {
    let info: Info
    
    enum CodingKeys: String, CodingKey {
        case info = "volumeInfo"
    }
}

struct Info: Codable {
    let title: String
    let authors: [String]
    let publisher: String
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks
}

struct ImageLinks: Codable {
    let small: String
    let normal: String
    
    enum CodingKeys: String, CodingKey {
        case small = "smallThumbnail"
        case normal = "thumbnail"
    }
}
