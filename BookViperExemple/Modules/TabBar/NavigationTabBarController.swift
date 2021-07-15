import Foundation
import UIKit

final class NavigationTabBarController: UITabBarController {
    private let tabBarHeight: CGFloat = 100
    private var factory: TabBarFactory = Factory()
    
    override func viewDidLoad() {
        setupTabBar()
    }
    
//    func setFactory(factory: TabBarFactory) {
//        self.factory = factory
//    }
    
    private func setupTabBar() {
        let tabItems: [TabItem] = [.explore, .favourite, .menu]
        setupView(items: tabItems)
        viewControllers = tabItems.map{ $0.getViewController(factory: factory)}
        tabBar.isHidden = true
    }
    
    private func setupView(items: [TabItem]) {
        let tabBarView = TabNavigationView()
        tabBarView.itemTapped = { [weak self] tabIndex in
            self?.changeTab(tab: tabIndex)
        }
        view.addSubview(tabBarView)
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tabBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tabBarView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tabBarView.heightAnchor.constraint(equalToConstant: tabBarHeight)
        ])
        tabBarView.setupView(tabItems: items)
    }
    
    private func changeTab(tab: Int) {
        self.selectedIndex = tab
    }
    
    
}
