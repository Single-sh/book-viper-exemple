import Foundation
import Moya

protocol TabBarFactory {
    func getMainViewController() -> UIViewController
    func getFavouriteViewController() -> UIViewController
}

protocol GeneralFactory {
    func getAboutViewController(book: BookProtocol) -> UIViewController
}

protocol MainFactory: GeneralFactory {}
protocol FavouriteFactory: GeneralFactory {}

class Factory: MainFactory, FavouriteFactory {
    private let networkManager = NetworkManager(baseUrl: "https://www.googleapis.com/books/v1")
    private let repo = BookDataBase()
}

extension Factory: TabBarFactory {
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
    func getFavouriteViewController() -> UIViewController {
        let controller = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
        let interactor = FavouriteInteractor(dataBase: repo)
        let router = FavouriteRouter(view: controller, factory: self)
        let presenter = FavouritePresenter(view: controller, interactor: interactor, router: router)
        controller.setPresenter(presenter: presenter)
        controller.title = "FAVOURITE"
        let navigation = BooksNavigationBar(rootViewController: controller)
        return navigation
    }
}

extension Factory: GeneralFactory {
    func getAboutViewController(book: BookProtocol) -> UIViewController {
        let controller = AboutViewController(nibName: "AboutViewController", bundle: nil)
        let interactor = AboutInteractor(repo: repo)
        let presenter = AboutPresenter(view: controller, interactor: interactor, book: book)
        controller.setPresenter(presenter: presenter)
        return controller
    }
}
