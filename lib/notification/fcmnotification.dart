import 'package:firebase_messaging/firebase_messaging.dart';

class FcmNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void RegisterNotificationHandler(
      Function(Map<String, dynamic>) notificationHandler) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        notificationHandler(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        notificationHandler(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        notificationHandler(message);
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);

      ///setState(() {
      //_homeScreenText = "Push Messaging token: $token";
      // });
    });
  }
}
