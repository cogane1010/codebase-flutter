import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'router.dart';

class Messaging {
  static const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description: 'This channel is used for important notifications.', // description
    importance: Importance.max,
  );

  static Future<void> initFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // TODO: handle if user rejects notification permission here

    // setup localNotification
    setupLocalNotification();

    // setup action when user clicks on notification
    setupInteractedMessage();

    // listen background message
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

    // listen foreground message
    listenForegroundMessage();
  }

  static void setupLocalNotification() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/icon_app');
    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();
    final InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectLocalNotification);
  }

  static Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from a terminated state.
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    // check if initialMessage not null, handle it
    if (initialMessage != null) {
      onSelectRemoteMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(onSelectRemoteMessage);
  }

  static void onSelectRemoteMessage(RemoteMessage message) {
    // do sth here
    // baseRoute.Routing.notificationRouting(message.data);
    AppRouter.inAppRouting();
  }

  static Future<String?> getFirebaseToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    return token;
  }

  static Future onSelectLocalNotification(String? payload) async {
    if (payload != null) {
      print('selectNotification payload: ' + payload);
      // baseRoute.Routing.notificationRouting(json.decode(payload));
      AppRouter.inAppRouting();
    }
  }

  static void showLocalNotification(RemoteMessage message) {
    RemoteNotification notification = message.notification!;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    // show local notification
    flutterLocalNotificationsPlugin.show(
        0,
        notification.title,
        notification.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              importance: Importance.max,
              priority: Priority.high,
            ),
            iOS: IOSNotificationDetails()),
        payload: json.encode(message.data));
  }

  static Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  static void listenForegroundMessage() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      /// TODO reload list notification if current us page notification
      // if current route is notifications list, reload list

      /// set page on icon app
      String badgeCount = message.data['badge'] ?? '1';
      if (badgeCount == 0) {
        FlutterAppBadger.removeBadge();
      } else {
        FlutterAppBadger.updateBadgeCount(int.parse(badgeCount));
      }


      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');

        showLocalNotification(message);
      } else {
        // handle silent message with data
        AppRouter.silentRouting(message.data);
      }
    });
  }
  Future<String?> getTokenFirebase() async {
   return await Messaging.getFirebaseToken();
  }
}

