//
//  AppDelegate.swift
//  AdiChallenge
//
//  Created by Tolga Taş on 24.03.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initializeWindow()

        return true
    }
    
    func initializeWindow() {
        let w = UIWindow()
        w.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
        w.frame = UIScreen.main.bounds
        w.backgroundColor = UIColor.black
        w.makeKeyAndVisible()
        self.window = w
    }
}

extension UIApplication {
    func topMostViewController() -> UIViewController? {
        return self.keyWindow?.rootViewController?.topMostViewController()
    }
}

extension UIViewController {
    func topMostViewController() -> UIViewController {

        if let presented = self.presentedViewController {
            return presented.topMostViewController()
        }

        if let navigation = self as? UINavigationController {
            return navigation.visibleViewController?.topMostViewController() ?? navigation
        }

        return self
    }
}

func showAlertOnTopMostViewController(title: String = "Adidas", message: String, actions: [UIAlertAction]) {
    DispatchQueue.main.async {
        guard let rootViewController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController else { return }
        
        let alertAction = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alertAction.addAction($0) }
        rootViewController.topViewController?.present(alertAction, animated: true, completion: nil)
    }
}
