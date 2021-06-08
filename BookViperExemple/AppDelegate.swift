import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
//        let factory = Factory()
//        window?.rootViewController = UINavigationController(rootViewController: factory.getMainViewController())
        window?.rootViewController = NavigationtabBarController()
        window?.makeKeyAndVisible()
        return true
    }


}

