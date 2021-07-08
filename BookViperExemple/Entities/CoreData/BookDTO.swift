import Foundation
import CoreData

class BookDTO: NSManagedObject {
//    static func createModel(from: BookProtocol, context: NSManagedObjectContext) -> BookDTO {
//
//    }
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

