import Foundation
import Moya

class Factory {
    private let networkManager = NetworkManager(baseUrl: "https://www.googleapis.com/books/v1")
    private let repo = BookRepo()
    
    func getMainViewController() -> UIViewController {
        let controller = MainViewController(nibName: "MainViewController", bundle: nil)
        let interactor = MainInteractor(remoute: networkManager)
        let router = MainRouter(view: controller, factory: self)
        let presenter = MainPresenter(view: controller, interactor: interactor, router: router)
        controller.setPresenter(presenter: presenter)
        controller.title = "EXPLORE"
        let navigation = BooksNavigationBar(rootViewController: controller)
        return navigation
    }
    
    func getAboutViewController(book: BookProtocol) -> UIViewController {
        let controller = AboutViewController(nibName: "AboutViewController", bundle: nil)
        let interactor = AboutInteractor(repo: repo)
        let presenter = AboutPresenter(view: controller, interactor: interactor, book: book)
        controller.setPresenter(presenter: presenter)
        return controller
    }
}
