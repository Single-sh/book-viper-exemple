import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let controller = NavigationTabBarController()
//        let factory = Factory()
//        controller.setFactory(factory: factory)
        window?.rootViewController = controller
        window?.makeKeyAndVisible()
        
        BooksNavigationBar.setupAppearance()
        return true
    }


}

