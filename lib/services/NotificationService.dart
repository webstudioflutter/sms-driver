import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:driver_app/Repository/auth/AuthenticationRepository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _messaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();
  bool _isFlutterLocalNotificationsInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Request permission
    await _requestPermission();
    // Setup message handlers
    await _setupMessageHandlers();
    // Get FCM token
    final token = await FirebaseMessaging.instance.getToken();
    if (token != null) {
      authenticationRepository.fcmtoken(token);
      log("mahesh token $token");
    }
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    print('Permission status: ${settings.authorizationStatus}');
  }

  Future<void> setupFlutterNotifications() async {
    if (_isFlutterLocalNotificationsInitialized) {
      return;
    }

    // Android setup
    var channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
          'This channel is used for important notifications.', // description
      importance: Importance.high,
      sound:
          RawResourceAndroidNotificationSound('notification'), // Custom sound
      playSound: true, // Ensure sound is played
      enableVibration: true, // Enable vibration
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS setup
    final initializationSettingsDarwin = DarwinInitializationSettings();

    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    // Flutter local notifications setup
    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {
        onForegroundNotificationResponse(details);
        onBackgroundNotificationResponse(details);
        print('Notification clicked with payload: ${details.payload}');
      },
    );

    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    if (notification != null && android != null) {
      await _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Notifications',
            channelDescription:
                'This channel is used for important notifications.',
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            enableLights: true,
            enableVibration: true,
            playSound: true,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: message.data.toString(),
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    //foreground message
    FirebaseMessaging.onMessage.listen((message) {
      showNotification(message);
    });

    // background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    // opened app
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      _handleBackgroundMessage(initialMessage);
    }
  }

  @pragma('vm:entry-point')
  static void onForegroundNotificationResponse(
      NotificationResponse notificationResponse) {
    print('Notification tapped: ${notificationResponse.payload}');
    if (notificationResponse.payload != null) {
      final data = jsonDecode(notificationResponse.payload!);

      // Navigate to Notification Screen
      if (data['type'] == 'notification') {
        NavigationService.instance.navigateTo('notificationkey');
      }
    }
  }

  @pragma('vm:entry-point')
  static void onBackgroundNotificationResponse(
      NotificationResponse notificationResponse) {
    print('Background notification tapped: ${notificationResponse.payload}');
    if (notificationResponse.payload != null) {
      final data = jsonDecode(notificationResponse.payload!);
      // Navigate to Notification Screen
      if (data['type'] == 'notification') {
        NavigationService.instance.navigateTo('notificationkey');
      }
    }
  }

  void _handleBackgroundMessage(RemoteMessage message) {
    // Navigate to Notification Screen
    if (message.data['type'] == 'notification') {
      NavigationService.instance.navigateTo('notificationkey');
    }
  }
}

class NavigationService {
  NavigationService._();
  static final NavigationService instance = NavigationService._();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<void> navigateTo(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }
}
