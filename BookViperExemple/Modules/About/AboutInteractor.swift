import Foundation

class AboutInteractor: AboutInteractorProtocol {
    let repo: BookRepo
    
    required init(repo: BookRepo) {
        self.repo = repo
    }
    
    func save(book: BookProtocol) -> Bool {
        repo.saveBook(book: book)
    }
    
    func isContains(id: String) -> Bool {
        repo.isContains(id: id)
    }
}
