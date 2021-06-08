import Foundation
import UIKit

final class NavigationtabBarController: UITabBarController {
    private let tabBarHeight: CGFloat = 100
    
    override func viewDidLoad() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        let tabItems: [TabItem] = [.explore, .favourite, .menu]
        setupView(items: tabItems)
        viewControllers = tabItems.map{ $0.viewController}
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
