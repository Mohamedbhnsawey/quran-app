import 'dart:convert';
import 'package:async/async.dart';
import 'package:adhan/adhan.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/model/azkar_model.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/view/notif.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

class Qurancontroller extends Cubit<QuranStates> {
  Qurancontroller() : super(QuranInitStates());

  static Qurancontroller get(context) => BlocProvider.of(context);

  int azkar = 0;
  List<dynamic> zeros = [];
  void azkartap({required int azkarlength, required int index}) {
    //print("after $zeros");
    if (zeros.isEmpty) {
      zeros = List.filled(azkarlength, 0);
      //print("before $zeros");
    }
    zeros[index]++;
    //print("ttttttttt $zeros");

    emit(QuranazkartapChangeStates());
    //return zeros;
  }

  void removeAzkar() {
    emit(QuranRemoveAzkarStates());
  }

  String? aya;
  String? surah;
  String? surahAr;
  void cashsaved() {
    surahAr = cashhelper.getdata(key: 'surah_ar') ?? '--';
    surah = cashhelper.getdata(key: 'surah_en') ?? '--';
    aya =
        getLocal() == 'ar'
            ? cashhelper.getdata(key: 'aya_ar')
            : cashhelper.getdata(key: 'aya_en') ?? '--';

    LocalNotification.showDailySchduledNotification();
    emit(QuranGetCashStates());
  }

  Map<String, dynamic> jsonDataMap = {};
  List<dynamic> jsonDataList = [];
  List<dynamic> jsonDataListSearch = [];
  Future<void> loadJsonAsset({required String json}) async {
    final String jsonString = await rootBundle.loadString(json);
    final data = jsonDecode(jsonString);
    if (data is List<dynamic>) {
      jsonDataList = data;
      jsonDataListSearch = data;
    } else {
      jsonDataMap = data;
    }
    emit(QuranLoadJsonSuccessStates());
  }

  var surahctr = TextEditingController();
  void surahSearch({required String p0}) {
    jsonDataListSearch =
        jsonDataList
            .where(
              (surah) =>
                  surah['titleAr'].toString().contains(p0) ||
                  surah['title'].toString().toLowerCase().contains(
                    p0.toLowerCase(),
                  ),
            )
            .toList();

    emit(QuranGetSurahSearchStates());
  }

  var azkarModel = [];
  void getAzkar({required String element}) {
    emit(QuranGetAzkarLoadingStates());
    rootBundle
        .loadString("assets/json/azkar/azkar.json")
        .then((onValue) {
          azkarModel = jsonDecode(onValue) as List<dynamic>;
          azkarModel
              .map((e) => AzkarModel.fromJson(e as Map<String, dynamic>))
              .toList();
          for (var item in azkarModel) {
            String category = item[element];
            if (!categoriesNames.contains(category)) {
              categoriesNames.add(category);
            }
          }
          searchData = categoriesNames;
          emit(QuranGetAzkarSuccessStates());
        })
        .catchError((onError) {
          emit(QuranGetAzkarErrorStates());
        });
  }

  List<String> searchData = [];
  loadJsonReciters() {
    return memoizer.runOnce(() async {
      final String jsonString = await rootBundle.loadString(
        'assets/json/reciters.json',
      );
      final y = jsonDecode(jsonString);
      return y['reciters'];
    });
  }

  void closeAudio() {
    player.stop();
    playAudioIcon2 = false;
    emit(QuranLoadJsonSuccessStates());
  }

  bool playAudioIcon = false;
  void changeplayAudioIcon() async {
    playAudioIcon = !playAudioIcon;
    playAudioIcon ? player.pause() : player.resume();
    emit(QuranChangePlayAudioIconStates());
  }

  int suraindex = 0;
  bool playAudioIcon2 = false;
  void changeplayAudioIcon2({
    required String suraNum,
    String url = 'https://download.quranicaudio.com/qdc/abdul_baset/murattal/',
  }) async {
    suraindex = int.parse(suraNum) - 1;
    playAudioIcon2 = true;
    playAudioIcon = false;

    // player = AudioPlayer();
    await player.stop();
    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    await player.play(UrlSource('$url$suraNum.mp3'));
    //await player.resume();
    emit(QuranChangePlayAudioIconStates2());
  }

  List<List<dynamic>> jsonData = [];
  Future<void> loadJsonFiles() async {
    try {
      // Load each JSON file asynchronously
      for (int i = 1; i <= 4; i++) {
        String jsonString = await rootBundle.loadString(
          'assets/json/taffser/file$i.json',
        );
        List<dynamic> data = jsonDecode(jsonString);
        jsonData.add(data); // Combine data from all files
      }
      emit(QuranGetFourSuccessStates());
    } catch (e) {
      emit(QuranGetFourErrorStates());
    }
  }

  String convertToArabicNumber(String number) {
    String res = '';
    final arabics = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    for (var element in number.characters) {
      res += arabics[int.parse(element)];
    }
    return res;
  }

  List<String> categoriesNames = [];
  Future<List<String>> extractUniqueCategories({
    required String element,
  }) async {
    for (var item in azkarModel) {
      String category = item[element];
      if (!categoriesNames.contains(category)) {
        categoriesNames.add(category);
      }
    }

    return Future.value(categoriesNames);
  }

  List<String> filteredFruits = [];
  void onChanged({required String p0}) {
    filteredFruits =
        categoriesNames
            .where((fruit) => fruit.contains(p0))
            .toList(); // Output: [apple]
    searchData = filteredFruits;
    emit(QuranGetSearchStates());
  }

  List<dynamic> categories = [];

  void extractCategories({required String element}) {
    for (var item in azkarModel) {
      if (item['category'] == element) {
        categories.add(item);
      }

      // String category = item[element];
      // if (!categoriesNames.contains(category)) {
      //   categoriesNames.add(category);
      // }
    }
    // return Future.value(categoriesNames);
  }

  // Store the calculated prayer times
  // Flag to indicate location permission status
  bool hasLocationPermission = false;

  Future<void> checkLocationPermission() async {
    // Step 1: Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      print("Location services are disabled.");
      return;
    }

    // Step 2: Check and request permission
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permission denied forever. Opening app settings.");
      await Geolocator.openAppSettings();
      return;
    }

    hasLocationPermission =
        permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;

    if (hasLocationPermission) {
      await getCurrentLocation();
      emit(QuranHasLocationPermissionStates());
    } else {
      print("Location permission not granted.");
    }
  }

  Future<void> getCurrentLocation() async {
    try {
      // Step 3: Get current position
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
      );

      // Step 4: Get time zone
      final String currentTimeZone = await FlutterTimezone.getLocalTimezone();

      // Step 5: Save location and timezone (replace `cashhelper` with your actual helper)
      cashhelper.savedata(key: 'latitude', value: position.latitude);
      cashhelper.savedata(key: 'longitude', value: position.longitude);
      cashhelper.savedata(key: 'timezone', value: currentTimeZone);

      print("Current Location: ${position.latitude}, ${position.longitude}");
      print("Current Timezone: $currentTimeZone");

      // Step 6: Calculate prayer times
      calculatePrayerTimes();
    } catch (e) {
      print("Error getting location: $e");
      // Optional: emit error state
    }
  }

  List<dynamic>? prayTimes;
  List<dynamic> quran = [
    "التفسير الميسر",
    "English",
    "معاني الكلمات",
    "ألإعراب",
  ];
  List<dynamic> prayTimesNames = [
    "الفجر",
    "الظهر",
    "العصر",
    "المغرب",
    "العشاء",
  ];
  String getCurrentAndNextPray({required String pray}) {
    switch (pray) {
      case "Prayer.fajr":
        return prayTimesNames[0]; // Muharram
      case "Prayer.sunrise":
        return 'الشروق'; // Safar
      case "Prayer.dhuhr":
        return prayTimesNames[1]; // Rabi' al-Awwal
      case "Prayer.asr":
        return prayTimesNames[2]; // Rabi' ath-Thani
      case "Prayer.maghrib":
        return prayTimesNames[3]; // Jumada al-Awwal
      case "Prayer.isha":
        return prayTimesNames[4]; // Jumada ath-Thaniyah
      case "Prayer.none":
        return prayTimesNames[0]; // Jumada ath-Thaniyah

      default:
        return '--'; // Unknown month
    }
  }

  var nextPrayerTime = '';
  var currentPrayerTime = '';
  var eqamaTime = '';
  // Calculate prayer times based on location
  void calculatePrayerTimes() {
    prayTimes = [];
    Coordinates coordinates = Coordinates(
      cashhelper.getdata(key: 'latitude'),
      cashhelper.getdata(key: 'longitude'),
    );
    //Coordinates coordinates = Coordinates(latitude, longitude);
    var param = CalculationMethod.egyptian.getParameters();
    param.madhab = Madhab.shafi;
    prayerTime = PrayerTimes.today(coordinates, param);
    prayTimes!.add(DateFormat.jm('en').format(prayerTime!.fajr));
    prayTimes!.add(DateFormat.jm('en').format(prayerTime!.dhuhr));
    prayTimes!.add(DateFormat.jm('en').format(prayerTime!.asr));
    prayTimes!.add(DateFormat.jm('en').format(prayerTime!.maghrib));
    prayTimes!.add(DateFormat.jm('en').format(prayerTime!.isha));
    currentPrayerTime = DateFormat.jm(
      'en',
    ).format(prayerTime!.timeForPrayer(prayerTime!.currentPrayer())!);
    eqamaTime = DateFormat.jm('en').format(
      prayerTime!
          .timeForPrayer(prayerTime!.currentPrayer())!
          .add(
            Duration(
              minutes:
                  "${prayerTime!.currentPrayer()}" == "Prayer.maghrib" ? 5 : 15,
            ),
          ),
    );
    nextPrayerTime = DateFormat.jm('en').format(
      prayerTime!.timeForPrayer(prayerTime!.nextPrayer()) ?? prayerTime!.fajr,
    );

    // print("the next prayer is${prayerTime!.currentPrayer()}");
    emit(QuranCalculatePrayerTimesStates());
  }

  late AudioPlayer player = AudioPlayer();
  String generateNumbers({required numm}) {
    String formattedNumber;
    if (numm < 10) {
      formattedNumber = '00$numm';
      // 00 for 1-9
    } else if (numm < 100) {
      formattedNumber = '0$numm';
      // 0 for 10-99
    } else {
      formattedNumber = numm.toString(); // No padding for 100+
    }
    return formattedNumber;
  }

  void enableWakeLock() {
    WakelockPlus.enable();
    emit(QuranEnableWakelockStates());
  }

  void diableWakeLock() {
    WakelockPlus.disable();
    emit(QuranDisableWakelockStates());
  }

  bool hasPermission = false;

  Future getPermission() async {
    if (await Permission.location.serviceStatus.isEnabled) {
      var status = await Permission.location.status;
      if (status.isGranted) {
        hasPermission = true;
      } else {
        Permission.location.request().then((value) {
          hasPermission = (value == PermissionStatus.granted);
          emit(QuranDisableWakelockStates());
        });
      }
    }
  }

  int drawerLang = Intl.getCurrentLocale() == 'ar' ? 0 : 1;
  void changeDrawerLang({required int index}) {
    drawerLang = index;

    emit(QuranchangeDrawerLangStates());
  }

  int drawerMode = cashhelper.getdata(key: 'mode') == true ? 1 : 0;
  void changeDrawerMode({required int index, required bool isDarkk}) {
    drawerMode = index;
    emit(QuranchangeDrawerModeStates());
  }

  void changeDrawerFontSize({required double index}) {
    fontsize = index;
    cashhelper.savedata(key: 'fontSize', value: index);
    emit(QuranchangeDrawerFontSizeStates());
  }

  bool drawerScreenTime = true;
  void changeDrawerScreenTime({required bool checked}) {
    if (checked) {
      enableWakeLock();
    } else {
      diableWakeLock();
    }
    drawerScreenTime = !drawerScreenTime;
    emit(QuranchangeDrawerScreenTimeStates());
  }

  void changeDrawerShowClock({required bool checked}) {
    showclock = !showclock;
    emit(QuranchangeDrawerShowClockStates());
  }

  String getLocal() {
    return Intl.getCurrentLocale();
  }

  bool showSearch = false;
  void showSearchField() {
    showSearch = !showSearch;
    emit(QuranShowSearchSuccessStates());
  }

  final TextEditingController controller = TextEditingController();
  final AsyncMemoizer memoizer = AsyncMemoizer();
}
