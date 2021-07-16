import Foundation
import UIKit

enum TabItem: String, CaseIterable {
    case explore
    case favourite
    case menu
    
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
