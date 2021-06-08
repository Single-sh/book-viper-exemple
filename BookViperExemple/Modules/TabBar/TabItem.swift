import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case explore
    case favourite
    case menu
    var viewController: UIViewController {
        switch self {
        case .explore:
            let factory = Factory()
            let controller = factory.getMainViewController()
            controller.tabBarItem.title = rawValue
            return controller
        case .favourite:
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.blue
            controller.tabBarItem.title = rawValue
            return controller
        case .menu:
            let controller = UIViewController()
            controller.view.backgroundColor = UIColor.orange
            controller.tabBarItem.title = rawValue
            return controller
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .explore:
            return UIImage(named: "search")
        case .favourite:
            return UIImage(named: "favourite")
        case .menu:
            return UIImage(named: "menu")
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
}
