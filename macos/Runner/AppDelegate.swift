import Cocoa
import FlutterMacOS
import Firebase
import UIKit

FirebaseApp.configure() 
GeneratedPluginRegistrant.register(with: self)

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
  override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return true
  }
}
