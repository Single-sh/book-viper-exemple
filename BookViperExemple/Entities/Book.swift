import Foundation

struct ListBooks: Codable {
    let totalItems: Int
    let items: [Book]
}

struct Book: Codable {
    let id: String?
    let volumeInfo: Info
}

struct Info: Codable {
    let title: String
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
}

protocol BookProtocol {
    var title: String? {get}
    var id: String? {get}
    var authors: [String]? {get}
    var publisher: String? {get}
    var publishedDate: String? {get}
    var descriptionBook: String? {get}
    var smallThumbnail: String? {get}
    var thumbnail: String? {get}
}

extension Book: BookProtocol {
    
    var title: String? {
        volumeInfo.title
    }
    
    var authors: [String]? {
        volumeInfo.authors
    }
    
    var publisher: String? {
        volumeInfo.publisher
    }
    
    var publishedDate: String? {
        volumeInfo.publishedDate
    }
    
    var descriptionBook: String? {
        volumeInfo.description
    }
    
    var smallThumbnail: String? {
        volumeInfo.imageLinks?.smallThumbnail
    }
    
    var thumbnail: String? {
        volumeInfo.imageLinks?.thumbnail
    }
    
    
}
