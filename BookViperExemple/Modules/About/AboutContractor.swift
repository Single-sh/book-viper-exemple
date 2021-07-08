import Foundation
import UIKit

protocol AboutViewProtocol: AnyObject {
    func showBook(book: BookProtocol)
    func setupFavourite(action: FavouriteAction)
}

protocol AboutPresenterProtocol: AnyObject {
    init(view: AboutViewProtocol, interactor: AboutInteractorProtocol, book: BookProtocol)
    func viewDidLoad()
    func favouriteButtonTap()
}

protocol AboutInteractorProtocol: AnyObject {
    init(repo: BookRepo)
    func save(book: BookProtocol) -> Bool
    func isContains(id: String) -> Bool 
}

enum FavouriteAction: String {
    case save = "Add to my favourite"
    case remove = "Remove from my favourite"
    
    var tintColor: UIColor {
        switch self {
        case .save:
            return .white
        case .remove:
            return .red
        }
    }
}
