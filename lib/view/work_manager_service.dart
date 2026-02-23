import 'package:adhan/adhan.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/view/notif.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';
// steps
//1.init work manager
//2.excute our task.
//3.register our task in work manager

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      frequency: const Duration(hours: 24),
      initialDelay: const Duration(minutes: 1),
    );
  }

  //init work manager service
  Future<void> init() async {
    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  void cancelTask(String id) {
    Workmanager().cancelAll();
  }
}

@pragma('vm:entry-point')
void actionTask() {
  //show notification
  Workmanager().executeTask((taskName, inputData) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
    Coordinates coordinates = Coordinates(
        prefs.getDouble('latitude')!, prefs.getDouble('longitude')!);
    var param = CalculationMethod.egyptian.getParameters();
    param.madhab = Madhab.shafi;
    prayerTime = PrayerTimes.today(coordinates, param);
    var time = [];
    time.add(prayerTime!.fajr);
    time.add(prayerTime!.dhuhr);
    time.add(prayerTime!.asr);
    time.add(prayerTime!.maghrib);
    time.add(prayerTime!.isha);
    for (int i = 0; i < time.length; i++) {
      LocalNotification.testttt(
        id: i,
        time: time[i],
        language: prefs.getString('language') ?? 'ar',
        timezone: prefs.getString('timezone')??'Africa/Cairo'
        // latitude: prefs.getDouble('latitude')!,
        // longitude: prefs.getDouble('longitude')!
      );
    }
    return Future.value(true);
  });
}

//1.schedule notification at 9 pm.
//2.execute for this notification.