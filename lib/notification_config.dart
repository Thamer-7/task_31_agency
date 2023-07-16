import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

initialFireBaseMessages() async {
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  FirebaseMessaging.instance.getInitialMessage().then((value) {
    handlePayLoad(json.encode(value?.data ?? {}));
  });

  FirebaseMessaging.onMessage.listen(showFlutterNotification);

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    handlePayLoad(json.encode(message.data));
  });
}

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  channel = const AndroidNotificationChannel(
    'MenaMEPlus', // id
    'MenaMEPlus', // title
    description:
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings(
    'mipmap/ic_launcher',
  );
  final DarwinInitializationSettings initializationSettingsIOS =
  DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {});
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: selectNotification);
  isFlutterLocalNotificationsInitialized = true;
  initialFireBaseMessages();
}

void selectNotification(NotificationResponse notificationResponse) async {
  String? payload = notificationResponse.payload;
  await handlePayLoad(payload);
}

Future<void> handlePayLoad(String? payload) async {

}

void showFlutterNotification(RemoteMessage message) {
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  PayloadData payloadData = PayloadData.fromJson(message.data);
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      payload: json.encode(message.data),
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          fullScreenIntent: true,
          channel.name,
          channelDescription: channel.description,
          icon: 'mipmap/ic_launcher',
        ),
      ),
    );
  }
}


late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

class PayloadData {
  String? msg;
  String? fragment;
  String? sound;
  String? body;
  String? title;
  String? otherDeviceInfo;
  String? city;
  String? otherDeviceToken;
  String? extra;
  String? lang;
  String? wfSerial;
  String? code;
  String? deviceType;

  PayloadData(
      {this.msg,
        this.fragment,
        this.lang,
        this.sound,
        this.deviceType,
        this.extra,
        this.otherDeviceInfo,
        this.otherDeviceToken,
        this.city,
        this.body,
        this.title,
        this.wfSerial,
        this.code});

  PayloadData.fromJson(Map<String, dynamic> json) {
    otherDeviceToken = json['otherDeviceToken'];
    otherDeviceInfo = json['otherDeviceInfo'];
    city = json['city'];
    msg = json['msg'];
    lang = json['lang'];
    fragment = json['fragment'];
    sound = json['sound'];
    body = json['body'];
    title = json['title'];
    wfSerial = json['wf_serial'];
    deviceType = json['otherDeviceType'];
    code = json['Code'];
    extra = json['extra'];
    if (code == '69') {
      List<String> listData = [];
      listData = extra?.split(',') ?? [];
      try {
        if (listData.isNotEmpty) {
          otherDeviceInfo = '${listData[0]} ${listData[1]}';
          deviceType = listData[1];
          city = listData[2];
          otherDeviceToken = listData[3];
          lang = listData[4];
        }
      } catch (e) {
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city'] = city;
    data['otherDeviceInfo'] = otherDeviceInfo;
    data['otherDeviceToken'] = otherDeviceToken;
    data['otherDeviceType'] = deviceType;
    data['msg'] = msg;
    data['fragment'] = fragment;
    data['sound'] = sound;
    data['body'] = body;
    data['title'] = title;
    data['wf_serial'] = wfSerial;
    data['Code'] = code;
    data['extra'] = extra;
    data['lang'] = lang;
    return data;
  }
}
