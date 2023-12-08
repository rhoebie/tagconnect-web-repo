import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApiService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: false,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    final fCMToken = await _firebaseMessaging.getToken(
        vapidKey:
            'BBBVTTmkvRoQ4P2VYtvWOYtiTjDsZX7aZF-8QFkQ-72OGIcjgke9_LkNB4gWVWKkdtmhJF4mkxZ1JlrJ8Edl9Ss');
    print('Token: $fCMToken');
  }
}
