import Foundation

protocol MainViewProtocol: AnyObject {
//    var presenter: MainPresenterProtocol { get set }
    func showBooks(books: [Book])
}

protocol MainPresenterProtocol: AnyObject {
//    var router: MainRouterProtocol { get set }
//    var view: MainViewProtocol { get set }
//    var iteractor: MainInteractorProtocol { get set }
    func searchBooks(search: String)
    func showBooks(books: [Book])
}

protocol MainInteractorProtocol: AnyObject {
//    var presenter: MainPresenterProtocol { get set }
    func getBooks(search: String)
}

protocol MainRouterProtocol: AnyObject {
    
}
