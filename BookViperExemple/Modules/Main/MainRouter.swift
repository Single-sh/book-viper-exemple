import Foundation

class MainRouter: MainRouterProtocol {
    unowned var view: MainViewController
    
    init(view: MainViewController) {
        self.view = view
    }
}
