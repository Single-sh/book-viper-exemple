import Foundation

class MainRouter: MainRouterProtocol {
    private unowned var view: MainViewController
    
    required init(view: MainViewController) {
        self.view = view
    }
}
