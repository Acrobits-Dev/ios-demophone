import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard scene is UIWindowScene else { return }

        // UIKit creates the window and root controller from the scene storyboard.
        let appDelegate = AppDelegate.theApp()
        appDelegate.window = window
        appDelegate.refreshCallViews()

        // Call intents can arrive while launching as well as while running.
        for userActivity in connectionOptions.userActivities {
            _ = appDelegate.handleUserActivity(userActivity)
        }
    }

    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        _ = AppDelegate.theApp().handleUserActivity(userActivity)
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NEAppPushManagerHandler.instance.initialize()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        let appDelegate = AppDelegate.theApp()
        if appDelegate.window === window {
            appDelegate.window = nil
        }
    }
}
