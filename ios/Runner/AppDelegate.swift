import UIKit
import Flutter
import SBPaySDK


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
  var flutterResultGb : FlutterResult?;

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
      let paymentChannel = FlutterMethodChannel(name: "com.brg.brgmanagementandroid/seabank_sdk",
                                                binaryMessenger: controller.binaryMessenger)
      paymentChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          let arguments = call.arguments as? [String: String]
          self.flutterResultGb = result;
          switch call.method {
          case "init":
              NotificationCenter.default.addObserver(self, selector: #selector(self.actionNotifiAddFundSuccess), name: NSNotification.Name(rawValue: SBPay.sharedInstance.notifiAddFundSuccess), object: nil)
              PaymentService.initSDK(controller, arguments: arguments, result: result)
          case "link_card":
              PaymentService.linkCard(controller, arguments: arguments, result: result)
          case "get_card_list":
              PaymentService.getCardList(arguments: arguments, result: result)
          case "unlink_card":
              PaymentService.unlinkCard(arguments: arguments, result: result)
          case "service_payment":
              PaymentService.servicePayment(arguments: arguments, result: result)
          case "cancel_payment":
              PaymentService.cancelPayment(arguments: arguments, result: result)
          case "send_otp_with_info":
              PaymentService.sendSmsOtp(arguments: arguments, result: result)
          default:
              result(FlutterMethodNotImplemented)
          }
      })
      
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
