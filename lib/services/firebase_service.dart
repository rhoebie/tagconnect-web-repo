import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApiService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      await _firebaseMessaging.requestPermission();

      String fCMToken = await _firebaseMessaging.getToken(
              vapidKey:
                  'BBBVTTmkvRoQ4P2VYtvWOYtiTjDsZX7aZF-8QFkQ-72OGIcjgke9_LkNB4gWVWKkdtmhJF4mkxZ1JlrJ8Edl9Ss') ??
          '';
      await prefs.setString('fCMToken', fCMToken);
      print('Token: $fCMToken');
    } catch (e) {
      print('Error initializing notifications: $e');
    }
  }
}
