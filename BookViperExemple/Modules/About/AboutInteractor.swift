import Foundation

final class AboutInteractor: AboutInteractorProtocol {
    let repo: AboutDataBaseProtocol
    
    required init(repo: AboutDataBaseProtocol) {
        self.repo = repo
    }
    
    func save(book: BookProtocol) -> Bool {
        repo.saveBook(book: book)
    }
    
    func remove(id: String) -> Bool {
        repo.removeBook(id: id)
    }
    
    func isContains(id: String) -> Bool {
        repo.isContains(id: id)
    }
}
