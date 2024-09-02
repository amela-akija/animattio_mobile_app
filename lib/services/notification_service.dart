// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// Future<void> backgroundHandler(NotificationResponse notificationResponse) async {
//   print('Notification received in background: ${notificationResponse.payload}');
// }
// class NotificationService{
//   final FlutterLocalNotificationsPlugin  notificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> initNotification() async{
//     AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings('logo');

//     var initializationSettingsIOS = DarwinInitializationSettings(requestAlertPermission: true, requestBadgePermission: true, requestSoundPermission: true, onDidReceiveLocalNotification:(id, title, body, payload) async{
      
//     });

//     var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings, onDidReceiveBackgroundNotificationResponse: backgroundHandler);
//   }

//   Future showNotification({int id=0, String? title, String? body, String? payload}) async{
//     return notificationsPlugin.show(id, title, body, await notificationDetails());
//   }
  
//   notificationDetails() {
//     return const NotificationDetails(android: AndroidNotificationDetails('channelId', 'channelName', importance: Importance.max),iOS: DarwinNotificationDetails());
//   }
// }