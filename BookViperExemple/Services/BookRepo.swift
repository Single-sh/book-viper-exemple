import Foundation
import UIKit
import CoreData

//DataBase layer
class BookRepo {
    private let context: NSManagedObjectContext
//    private lazy var context
    
    init() {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        context = container.viewContext
    }
    
    func getFavourite(completion: (([BookProtocol]) -> ())) {
        
    }
    
    func saveBook(book: BookProtocol) -> Bool {
        let imageLinks = ImageLinksDTO(context: context)
        imageLinks.smallThumbnail = book.smallThumbnail
        imageLinks.thumbnail = book.thumbnail
        let info = InfoDTO(context: context)
        info.title = book.title
        info.authors = book.authors
        info.publisher = book.publisher
        info.publishedDate = book.publishedDate
        info.descriptionBook = book.descriptionBook
        info.imageLinks = imageLinks
        let bookDTO = BookDTO(context: context)
        bookDTO.info = info
        bookDTO.id = book.id
        return saveContext()
    }
    
    func isContains(id: String) -> Bool {
        let fetch: NSFetchRequest<BookDTO> = BookDTO.fetchRequest()
        fetch.predicate = NSPredicate(format: "id = %@", id)
        do {
            let book = try? context.fetch(fetch)
            return book?.isEmpty == false
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    private func saveContext () -> Bool {
        if context.hasChanges {
            do {
                try context.save()
                return true
            } catch {
                context.rollback()
                let nserror = error as NSError
                print(nserror)
                return false
            }
        } else {
            return true
        }
    }
}
