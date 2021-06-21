import UIKit

class BooksNavigationBar: UINavigationController {
    
    static func setupAppearance() {
        let barAppearance = UINavigationBar.appearance(whenContainedInInstancesOf: [BooksNavigationBar.self])
        barAppearance.backgroundColor = .clear
        barAppearance.setBackgroundImage(UIImage(), for: .default)
        barAppearance.isTranslucent = true
        barAppearance.shadowImage = UIImage()
        barAppearance.prefersLargeTitles = true
        barAppearance.titleTextAttributes = [.foregroundColor: UIColor.clear]
    }
}
