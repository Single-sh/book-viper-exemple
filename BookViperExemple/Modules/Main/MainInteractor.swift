import Foundation
import Moya

class MainInteractor: MainInteractorProtocol {
    let remouteService: MoyaProvider<RemouteBookService>
    private weak var presenter: MainPresenterProtocol!
    
    init(remoute: MoyaProvider<RemouteBookService>) {
        self.remouteService = remoute
    }
    
    func setPresenter(presenter: MainPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getBooks(search: String) {
        remouteService.request(.getList(search: search)) { [weak presenter] result in
            switch result {
            case let .success(response):
                do {
                    let list = try response.map(ListBooks.self)
                    presenter?.showBooks(books: list.items)
                }
                catch {
                    print("Error parse ListBook")
                }
            case let .failure(error):
                print(error.errorDescription)
            }
        }
    }
    
}
