import Foundation
import CoreData

class BookDTO: NSManagedObject {
    static func createModel(from: BookProtocol, context: NSManagedObjectContext) -> BookDTO {
        let imageLinks = ImageLinksDTO(context: context)
        imageLinks.smallThumbnail = from.smallThumbnail
        imageLinks.thumbnail = from.thumbnail
        let info = InfoDTO(context: context)
        info.title = from.title
        info.authors = from.authors
        info.publisher = from.publisher
        info.publishedDate = from.publishedDate
        info.descriptionBook = from.descriptionBook
        info.imageLinks = imageLinks
        let bookDTO = BookDTO(context: context)
        bookDTO.info = info
        bookDTO.id = from.id
        return bookDTO
    }
}

extension BookDTO: BookProtocol {
    
    var title: String? {
        info?.title
    }
    
    var authors: [String]? {
        info?.authors
    }
    
    var publisher: String? {
        info?.publisher
    }
    
    var publishedDate: String? {
        info?.publishedDate
    }
    
    var descriptionBook: String? {
        info?.descriptionBook
    }
    
    var smallThumbnail: String? {
        info?.imageLinks?.smallThumbnail
    }
    
    var thumbnail: String? {
        info?.imageLinks?.thumbnail
    }
}

