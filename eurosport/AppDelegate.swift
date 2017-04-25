import UIKit
import TVMLKit

// This code is the standard application delegate for a Swift tvOS app. That's all the Swift boilerplate for TVML app.

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, TVApplicationControllerDelegate {
    
    var window: UIWindow?
    
    // appController hold of the controller object
    var appController: TVApplicationController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 1: Create a UIWindow object the same size and save it into the window property.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // 2: appControllerContext provide the launch properties to the application controller.
        let appControllerContext = TVApplicationControllerContext()
        
        // 3: Locate the initial JavaScript file with in the main bundle. You need to create this file manually.
        let javascriptURL = Bundle.main.url(forResource: "main", withExtension: "js")
        appControllerContext.javaScriptApplicationURL = javascriptURL!
        
        // 4: Create the TVApplicationController using the controller context.
        appController = TVApplicationController(context: appControllerContext, window: window, delegate: self)
        
        return true
    }
    
    // This method make it available of Loader inside the TV.
    func appController(_ appController: TVApplicationController, evaluateAppJavaScriptIn
        jsContext: JSContext) {
        
        jsContext.setObject(Loader.self, forKeyedSubscript: "NativeResourceLoader" as NSString)
    }
}
