import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotification {
  static FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static onTap(NotificationResponse details) {}

  static Future init() async {
    var status = await Permission.notification.request();
    if (status == PermissionStatus.granted) {
      // Initialize FlutterLocalNotificationsPlugin
      InitializationSettings settings = const InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings(),
      );
      notificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: onTap,
        onDidReceiveBackgroundNotificationResponse: onTap,
      );
    }
  }

  static void showBasicNotification() async {
    // Permission granted, proceed with notification setup
    NotificationDetails details = NotificationDetails(
        android: AndroidNotificationDetails("id 1", "Basic Notification",
            importance: Importance.max,
            playSound: true,
            priority: Priority.high,
            sound: RawResourceAndroidNotificationSound(
                'azan.mp3'.split('.').first)));
    await notificationsPlugin.show(0, "basic", "Body", details,
        payload: "payload");
    // Handle permission denial (e.g., show a message to the user)
  }

  static void showRepeatedNotification() async {
    // Permission granted, proceed with notification setup
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails("id 1", "repeated Notification",
            importance: Importance.max, priority: Priority.high));
    await notificationsPlugin.periodicallyShow(
      androidScheduleMode: AndroidScheduleMode.exact,
        1, "repeated", "Body", RepeatInterval.everyMinute, details,
        payload: "payload");
  }

  static void showScheduleNotification(DateTime selectedTime) async {
    // Permission granted, proceed with notification setup
    NotificationDetails details = const NotificationDetails(
        android: AndroidNotificationDetails("id 1", "repeated Notification",
            importance: Importance.max, priority: Priority.high));
    tz.initializeTimeZones();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    if (selectedTime.isBefore(DateTime.now())) {
      selectedTime = selectedTime.add(const Duration(seconds: 5));
    }
    final tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(selectedTime, tz.local);
    await notificationsPlugin.zonedSchedule(
      androidScheduleMode: AndroidScheduleMode.exact,
        1, "Schedule", "body", scheduledTime, details,
       );
  }

  static void showDailySchduledNotification() async {
    const AndroidNotificationDetails android = AndroidNotificationDetails(
      'daily schduled notification',
      'id 4',
      importance: Importance.max,
      priority: Priority.high,
    );
    NotificationDetails details = const NotificationDetails(
      android: android,
    );
    final durationUntilNextFriday = getDurationUntilNextFridayAt10AM();
    await notificationsPlugin.periodicallyShowWithDuration(
      3,
      'Quran',
      'الكهف نور يضيء ما بين الجُمعتين',
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
      durationUntilNextFriday,
      details,
      androidScheduleMode: AndroidScheduleMode.exact,
      payload: 'zonedSchedule',
    );
  }

  static void cancelNotification({required int id}) {
    notificationsPlugin.cancel(id);
  }

  static void testttt(
      {required DateTime time,
      required int id,
      required String timezone,
      required String language}) async {
    
      // Coordinates coordinates = Coordinates(latitude, longitude);
      // var param = CalculationMethod.egyptian.getParameters();
      // param.madhab = Madhab.shafi;

      //  prayerTime = PrayerTimes.today(coordinates, param);

      AndroidNotificationDetails android = AndroidNotificationDetails(
          'daily schduled notification', 'id 4',
          importance: Importance.max,
          priority: Priority.high,
          sound: RawResourceAndroidNotificationSound('azan'.split('.').first));
      NotificationDetails details = NotificationDetails(
        android: android,
      );
      //final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(timezone));
      var currentTime = tz.TZDateTime.now(tz.local);
      // var x = prayerTime!.timeForPrayer(
      //         prayerTime!.nextPrayer() == Prayer.sunrise
      //             ? Prayer.dhuhr
      //             : prayerTime!.nextPrayer()) ??
      //     prayerTime!.fajr;
      String pray = '';
      if (language == 'ar') {
        switch (id) {
          case 0:
            pray = 'الفجر'; // Muharram
          case 1:
            pray = 'الظهر'; // Rabi' al-Awwal
          case 2:
            pray = 'العصر'; // Rabi' ath-Thani
          case 3:
            pray = 'المغرب'; // Jumada al-Awwal
          case 5:
            pray = 'العشاء'; // Jumada ath-Thaniyah
          default:
            pray = '--'; // Unknown month
        }
      } else {
        switch (id) {
          case 0:
            pray = 'Fajr'; // Muharram
          case 1: 
            pray = 'Dhuhr'; // Rabi' al-Awwal
          case 2:
            pray = 'Asr'; // Rabi' ath-Thani
          case 3:
            pray = 'maghrib'; // Jumada al-Awwal
          case 5:
            pray = 'Isha'; // Jumada ath-Thaniyah
          default:
            pray = '--'; // Unknown month
        }
      }
      var scheduleTime = tz.TZDateTime(tz.local, time.year, currentTime.month,
          currentTime.day, time.hour, time.minute);

      if (scheduleTime.isBefore(currentTime)) {
        scheduleTime = scheduleTime.add(const Duration(days: 1));
      }

      await notificationsPlugin.zonedSchedule(
        id,
        'قرأن',
        language == 'ar'
            ? 'حان الأن موعد أذان $pray'
            : "${prayerTime!.nextPrayer()}".substring(7),
        scheduleTime,
        details,
        payload: 'zonedSchedule',
        androidScheduleMode: AndroidScheduleMode.exact,
      );

  }
}
