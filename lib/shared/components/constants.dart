// ignore_for_file: constant_identifier_names

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void signout(context) {
//   cashhelper.removedata(key: 'token').then((value) {
//     if (value) {
//       Navigateandfinish(context, CureiousLoginScreen());
//     }
//   });
// }

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  // ignore: avoid_print
  pattern.allMatches(text).forEach((match) => print(match.group(0)));
}

double fontsize = cashhelper.getdata(key: 'fontSize') ?? 24;
PrayerTimes? prayerTime;
bool showclock = false;

const primaryColor = Color(0xFF6F35A5);
const kprimaryColor2 = Color(0xFF006AD7);
const seconderyColor = Color(0xFF8789A3);
const DarkseconderyColor = Color(0xFF4A5C6A);
const kprimaryColor = Color(0xFF104C64);
const DarkContainerColor = Color.fromARGB(199, 50, 52, 56);
const primaryColor2 = Color(0xFF235347);
const DarkprimaryColor2 = Color(0xFF1B1D21);
//const primaryColor2 = Color(0xFFC9AD80);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const QuranDarkPrimaryColor = Color(0x9529343D);
const QuranDarkSecondaryColor = Color(0xFF1E2025);
const QuranPrimaryColor = Color(0xFF235347);
const QuranSecondaryColor = Color(0xFF8EB69B);
const double defaultPadding = 16.0;
Duration getDurationUntilNextFridayAt10AM() {
  final now = DateTime.now();
  DateTime nextFriday = DateTime(
    now.year,
    now.month,
    now.day,
    10, // 10 AM
  ).add(Duration(days: (DateTime.friday - now.weekday) % 7));

  if (nextFriday.isBefore(now)) {
    nextFriday = nextFriday.add(const Duration(days: 7));
  }
  return nextFriday.difference(now);
}

// ignore: camel_case_types
class cashhelper {
  static SharedPreferences? sharedPreferences;
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> savedata(
      {required String key, required dynamic value}) async {
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getdata({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removedata({required String key}) async {
    return await sharedPreferences!.remove(key);
  }
}
