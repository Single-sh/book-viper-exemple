import Foundation
import UIKit
import CoreData

protocol AboutDataBaseProtocol {
    func saveBook(book: BookProtocol) -> Bool
    func removeBook(id: String) -> Bool
    func isContains(id: String) -> Bool
}

protocol FavouriteDataBaseProtocol {
    func getFavourite(completion: (([BookProtocol]) -> ()))
}

class BookDataBase: AboutDataBaseProtocol, FavouriteDataBaseProtocol {
    private lazy var context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
    func getFavourite(completion: (([BookProtocol]) -> ())) {
        let fetch: NSFetchRequest<BookDTO> = BookDTO.fetchRequest()
        do {
            let books = try? context.fetch(fetch)
            let compactsBooks = books?.compactMap({$0}) ?? []
            completion(compactsBooks)
        }
        catch {
            print(error.localizedDescription)
            completion([])
        }
    }
    
    func saveBook(book: BookProtocol) -> Bool {
        _ = BookDTO.createModel(from: book, context: context)
        return saveContext()
    }
    
    func removeBook(id: String) -> Bool {
        guard let book = getBook(id: id) else {
            return true
        }
        context.delete(book)
        return saveContext()
    }
    
    func isContains(id: String) -> Bool {
        let book = getBook(id: id)
        return book != nil
    }
    
    private func getBook(id: String) -> BookDTO? {
        let fetch: NSFetchRequest<BookDTO> = BookDTO.fetchRequest()
        fetch.predicate = NSPredicate(format: "id = %@", id)
        do {
            let books = try? context.fetch(fetch)
            return books?.first
        }
        catch {
            print(error.localizedDescription)
            return nil
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
