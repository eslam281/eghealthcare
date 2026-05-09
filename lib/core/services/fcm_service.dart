import 'package:firebase_messaging/firebase_messaging.dart';

import '../../injection_container.dart';
import '../constants/links.dart';
import '../network/api_client.dart';
import '../network/network_call_handler.dart';
import 'notification_service.dart';

class FCMService {
  final FirebaseMessaging _messaging =
      FirebaseMessaging.instance;

  Future<void> init() async {

    await _messaging.requestPermission();

    final token = await _messaging.getToken();

    _messaging.onTokenRefresh.listen((newToken) async {
      print("NEW TOKEN => $newToken");
      // sl<NetworkCallHandler>().call(() =>
      //     sl<ApiClient>().post("${AppLinks.user}/${data.user!.uid}",
      //   body: {
      //     "fcmToken": newToken,
      //   },));
    });
    FirebaseMessaging.onMessage.listen((message) {

      final notification = message.notification;

      if (notification != null) {
        NotificationService.showNotification(
          title:
          notification.title ?? '',
          body:
          notification.body ?? '',
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp
        .listen((message) {

      print('Notification clicked');

    });
    final initialMessage = await _messaging.getInitialMessage();

    if (initialMessage != null) {

      print('App opened from terminated');
    }

    print('FCM TOKEN: $token');
  }
}