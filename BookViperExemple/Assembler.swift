import Foundation
import Moya

protocol AboutAssembler {
    func getAboutViewController(book: BookProtocol) -> UIViewController
}

protocol MainAssembler: AboutAssembler {}
protocol FavouriteAssembler: AboutAssembler {}

class Assembler: MainAssembler, FavouriteAssembler {
    private let networkManager = NetworkManager(baseUrl: "https://www.googleapis.com/books/v1")
    private let repo = BookDataBase()

    private func getMainViewController() -> UIViewController {
        let controller = MainViewController(nibName: "MainViewController", bundle: nil)
        let interactor = MainInteractor(remoute: networkManager)
        let router = MainRouter(view: controller, factory: self)
        let presenter = MainPresenter(view: controller, interactor: interactor, router: router)
        controller.setPresenter(presenter: presenter)
        return controller
    }
    
    private func getFavouriteViewController() -> UIViewController {
        let controller = FavouriteViewController(nibName: "FavouriteViewController", bundle: nil)
        let interactor = FavouriteInteractor(dataBase: repo)
        let router = FavouriteRouter(view: controller, factory: self)
        let presenter = FavouritePresenter(view: controller, interactor: interactor, router: router)
        controller.setPresenter(presenter: presenter)
        return controller
    }
    
    func getTabItemController(tabItem: TabItem) -> UIViewController {
        var controller: UIViewController!
        switch tabItem {
        case .explore:
            controller = getMainViewController()
        case .favourite:
            controller = getFavouriteViewController()
        case .menu:
            controller = UIViewController()
        }
        controller.title = tabItem.rawValue.uppercased()
        controller.tabBarItem.title = tabItem.rawValue.uppercased()
        let navigation = BooksNavigationBar(rootViewController: controller)
        return navigation
    }
}

extension Assembler: AboutAssembler {
    func getAboutViewController(book: BookProtocol) -> UIViewController {
        let controller = AboutViewController(nibName: "AboutViewController", bundle: nil)
        let interactor = AboutInteractor(repo: repo)
        let presenter = AboutPresenter(view: controller, interactor: interactor, book: book)
        controller.setPresenter(presenter: presenter)
        return controller
    }
}
