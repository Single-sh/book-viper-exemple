import Foundation

final class FavouriteRouter: FavouriteRouterProtocol {
    private unowned var view: FavouriteViewController
    private let factory: FavouriteAssembler
    
    required init(view: FavouriteViewController, factory: FavouriteAssembler) {
        self.view = view
        self.factory = factory
    }
    
    func showAboutView(book: BookProtocol) {
        let aboutController = factory.getAboutViewController(book: book)
        view.present(aboutController, animated: true)
    }
    
}
