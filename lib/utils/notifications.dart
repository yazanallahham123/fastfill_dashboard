import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../api/methods.dart';
import '../api/retrofit.dart';
import '../model/notifications/notification_body.dart';
import '../model/user/update_firebase_token_body.dart';
import '../model/user/user.dart';
import 'local_data.dart';

StreamController<NotificationBody> notificationsController = StreamController<NotificationBody>.broadcast();
Stream notificationsStream = notificationsController.stream;
Notifications notifications = Notifications();

class Notifications {

  final ApiClient mClient = ApiClient(certificateClient());

  Notifications._();

  factory Notifications() => _instance;

  static final Notifications _instance = Notifications._();

  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> init(
      StreamController<NotificationBody> notificationStreamController) async {
    NotificationSettings ns = await _fcm.getNotificationSettings();

    if (ns.authorizationStatus != AuthorizationStatus.authorized)
      {
        ns = await _fcm.requestPermission(
          alert: true,
          announcement: true,
          badge: true,
          carPlay: true,
          criticalAlert: true,
          provisional: true,
          sound: true
        );
      }

    FirebaseMessaging.onBackgroundMessage((message) async {
      var user = await getCurrentUserValue();

      print("notification background message: ${message.data}");
      NotificationBody notificationBody = NotificationBody(
          imageURL : message.data["imageURL"]?.toString() ?? "",
          title : message.data["title"]?.toString() ?? "",
          content : message.data["content"]?.toString() ?? "",
          notes : message.data["notes"]?.toString() ?? "",
          typeId : message.data["typeId"]?.toString() ?? "",
          date : message.data["date"]?.toString() ?? "",
          time : message.data["time"]?.toString() ?? "",
          price: message.data["price"]?.toString() ?? "",
          liters: message.data["liters"]?.toString() ?? "",
          address: message.data["address"]?.toString() ?? "",
          material: message.data["material"]?.toString() ?? "",
          userId: (user.id != null) ? user.id : 0
      );

        if (user.id != null) {
          if (user.id! > 0) {
            var token = await getBearerTokenValue();
            if (token != null)
              await mClient.addNotification(token, notificationBody);
          }
        }

    });

    FirebaseMessaging.onMessage.listen((message) async {
      var user = await getCurrentUserValue();

      print("notification message: ${message.data}");
      NotificationBody notificationBody = NotificationBody(
          imageURL : message.data["imageURL"]?.toString() ?? "",
          title : message.data["title"]?.toString() ?? "",
          content : message.data["content"]?.toString() ?? "",
          notes : message.data["notes"]?.toString() ?? "",
          typeId : message.data["typeId"]?.toString() ?? "",
          date : message.data["date"]?.toString() ?? "",
          time : message.data["time"]?.toString() ?? "",
          price: message.data["price"]?.toString() ?? "",
          liters: message.data["liters"]?.toString() ?? "",
          address: message.data["address"]?.toString() ?? "",
          material: message.data["material"]?.toString() ?? "",
      userId: (user.id != null) ? user.id : 0
      );

        if (user.id != null) {
          if (user.id! > 0) {
            var token = await getBearerTokenValue();
            if (token != null)
              await mClient.addNotification(token, notificationBody);
          }
        }

      notificationStreamController.sink.add(notificationBody);
    });

    FirebaseMessaging.instance.getToken().then((firebaseToken) async {
      if (firebaseToken != null) {
        print("firebase token: "+firebaseToken);
        await setFTokenValue(firebaseToken);
        User user = await getCurrentUserValue();
          if (user.id != null) {
            if (user.id! > 0) {
              var token = await getBearerTokenValue();
              if (token != null)
                print(await mClient.updateFirebaseToken(token, UpdateFirebaseTokenBody(firebaseToken: firebaseToken)));

            }
          }
      }
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((firebaseToken) async {
        print("firebase token: "+firebaseToken);
        await setFTokenValue(firebaseToken);
        User user = await getCurrentUserValue();
            if (user.id != null) {
              if (user.id! > 0) {
                  var token = await getBearerTokenValue();
                  if (token != null)
                    print(await mClient.updateFirebaseToken(token, UpdateFirebaseTokenBody(firebaseToken: firebaseToken)));

              }
            }
    });

  }
}