import UIKit
import Flutter


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  var flutterResultGb : FlutterResult?;

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      
    var flutter_native_splash = 1
    UIApplication.shared.isStatusBarHidden = false
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 13.0, *) {
             UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
           }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)

  }
    @objc func actionNotifiAddFundSuccess() {
        
        flutterResultGb!("refresh_list_account")
        
    }

   // disable screen shot, recoding
//     override func applicationWillResignActive(
//       _ application: UIApplication
//     ) {
//       self.window.isHidden = true;
//     }
//     override func applicationDidBecomeActive(
//       _ application: UIApplication
//     ) {
//       self.window.isHidden = false;
//     }
}
