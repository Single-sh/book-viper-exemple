import Foundation
final class MainPresenter: MainPresenterProtocol {
    
    private unowned var view: MainViewProtocol
    private var interactor: MainInteractorProtocol
    private var router: MainRouterProtocol
    
    private var data = [(title: String, books: [Book])]()
    
    required init(view: MainViewProtocol, interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func searchBooks(search: String) {
        let group = DispatchGroup()
        let searches = ["swift", "детские сказки", "камасутра", "готовка для чайников"]
        searches.forEach { search in
            group.enter()
            interactor.getBooks(search: search) {[weak self] result in
                switch result {
                case let .success(books):
                    self?.data.append((search, books))
                case let .failure(error):
                    print(error.description)
                }
                group.leave()
            }
        }
        group.notify(queue: .main) { [weak self] in
            self?.updateProgress(current: 0, max: searches.count)
        }
    }
    
    private func updateProgress(current: Int, max: Int) {
        if current == max {
            view.showBooks()
            return
        }
        let cur = current + 1
        let progress: Float = Float(100 / max * cur)
        view.updateProgressBar(progress: progress)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.updateProgress(current: cur, max: max)
        }
    }
    
    func getCellCount(at section: Int) -> Int {
        data[section].books.count
    }
    
    func getCellData(indexPath: IndexPath) -> Book {
        data[indexPath.section].books[indexPath.row]
    }
    
    func getSectionCount() -> Int {
        data.count
    }
    
    func getSectionTitle(at section: Int) -> String {
        data[section].title
    }
    
    func selectCell(indexPath: IndexPath) {
        router.openAboutBook(book: data[indexPath.section].books[indexPath.row])
    }
}
