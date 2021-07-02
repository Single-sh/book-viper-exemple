import Foundation
import Moya

class Factory {
    private let networkManager = NetworkManager(baseUrl: "https://www.googleapis.com/books/v1")
    
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
    
    func getAboutViewController(book: Book) -> UIViewController {
        let controller = AboutViewController(nibName: "AboutViewController", bundle: nil)
        controller.book = book
        return controller
    }
}
