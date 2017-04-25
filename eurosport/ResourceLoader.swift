// Native resource loader

import JavaScriptCore

// JavaScriptCore uses the JSExport protocol to determine which methods and properties should be exposed in the JavaScript interface to the object.

// JavaScriptCore uses Objective-C runtime.
@objc protocol LoaderExport: JSExport {
    
    // create an instance
    static func create() -> LoaderExport
    
    // load a resource from the app bundle and return it as a String.
    func loadBundleResource(_ name: String) -> String
}

@objc class Loader: NSObject, LoaderExport {
    
    // This function return an instance. This function is necessary because JavaScriptCore doesn't bridge initializers.
    static func create() -> LoaderExport {
        return Loader()
    }
    
    func loadBundleResource(_ name: String) -> String {
        // Locate the path of the resource
        let path = Bundle.main.path(forResource: name, ofType: nil)
        
        do {
            return try String(contentsOfFile: path!, encoding: .utf8)
        } catch {

            return "There was a problem"
        }
    }
}
