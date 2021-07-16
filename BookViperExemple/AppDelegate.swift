import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    let assembler = Assembler()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setTabBar()
        BooksNavigationBar.setupAppearance()
        return true
    }

    
    private func setTabBar() {
        window = UIWindow()
        let tabItems: [TabItem] = [.explore, .favourite, .menu]
        let controller = NavigationTabBarController()
        controller.setTabItems(tabItems: tabItems)
        controller.viewControllers = tabItems.map({
            assembler.getTabItemController(tabItem: $0)
        })
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
    }

}

