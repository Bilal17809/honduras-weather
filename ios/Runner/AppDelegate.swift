// import Flutter
// import Firebase
// import UIKit
//
// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     FirebaseApp.configure()
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }

import Flutter
import UIKit
import Firebase
import OneSignalFramework




@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    OneSignal.initialize("d8874dbe-6e1e-4e57-a53c-4757915dfee2")
    // Initialize Firebase
     FirebaseApp.configure()
    // Register plugins
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
