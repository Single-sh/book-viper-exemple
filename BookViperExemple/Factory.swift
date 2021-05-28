import Foundation
import Moya

class Factory {
    let remouteService = MoyaProvider<RemouteBookService>()
    
    func getMainViewController() -> UIViewController {
        let controller = MainViewController(nibName: "MainViewController", bundle: nil)
        let interactor = MainInteractor(remoute: remouteService)
        let router = MainRouter(view: controller)
        let presenter = MainPresenter(view: controller, interactor: interactor, router: router)
        
        controller.setPresenter(presenter: presenter)
        interactor.setPresenter(presenter: presenter)
        return controller
    }
}
