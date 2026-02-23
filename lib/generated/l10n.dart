// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: 'Label for selecting the language',
      args: [],
    );
  }

  /// `Appearance`
  String get mode {
    return Intl.message(
      'Appearance',
      name: 'mode',
      desc: 'Label for selecting the theme or appearance mode',
      args: [],
    );
  }

  /// `FontSize`
  String get FontSize {
    return Intl.message(
      'FontSize',
      name: 'FontSize',
      desc: 'Label for adjusting the font size',
      args: [],
    );
  }

  /// `A`
  String get A {
    return Intl.message(
      'A',
      name: 'A',
      desc: 'Represents the letter A for font size scaling',
      args: [],
    );
  }

  /// `Show Clock`
  String get ShowClock {
    return Intl.message(
      'Show Clock',
      name: 'ShowClock',
      desc: 'Toggle for showing the clock on the interface',
      args: [],
    );
  }

  /// `Keep screen on while reading`
  String get keepScreen {
    return Intl.message(
      'Keep screen on while reading',
      name: 'keepScreen',
      desc: 'Toggle for keeping the screen on while reading',
      args: [],
    );
  }

  /// `Notifications`
  String get notification {
    return Intl.message(
      'Notifications',
      name: 'notification',
      desc: 'Label for managing notifications',
      args: [],
    );
  }

  /// `Read Al-Kahf every Friday`
  String get kahfNotification {
    return Intl.message(
      'Read Al-Kahf every Friday',
      name: 'kahfNotification',
      desc: 'Notification reminder to read Surah Al-Kahf every Friday',
      args: [],
    );
  }

  /// `Reading`
  String get reading {
    return Intl.message(
      'Reading',
      name: 'reading',
      desc: 'Label for reading section, like Quran reading',
      args: [],
    );
  }

  /// `Quran`
  String get quran {
    return Intl.message(
      'Quran',
      name: 'quran',
      desc: 'Label for Quran section',
      args: [],
    );
  }

  /// `Athkar`
  String get athkar {
    return Intl.message(
      'Athkar',
      name: 'athkar',
      desc: 'Label for the Athkar (daily remembrances)',
      args: [],
    );
  }

  /// `Qibla`
  String get qibla {
    return Intl.message(
      'Qibla',
      name: 'qibla',
      desc: 'Label for Qibla direction',
      args: [],
    );
  }

  /// `Current Prayer`
  String get currentPray {
    return Intl.message(
      'Current Prayer',
      name: 'currentPray',
      desc: 'Displays the current prayer name',
      args: [],
    );
  }

  /// `Next Prayer`
  String get nextPray {
    return Intl.message(
      'Next Prayer',
      name: 'nextPray',
      desc: 'Displays the next upcoming prayer',
      args: [],
    );
  }

  /// `Adhan`
  String get azan {
    return Intl.message(
      'Adhan',
      name: 'azan',
      desc: 'Label for the Adhan (call to prayer)',
      args: [],
    );
  }

  /// `Iqamah`
  String get eqama {
    return Intl.message(
      'Iqamah',
      name: 'eqama',
      desc: 'Label for the Iqama (second call to prayer)',
      args: [],
    );
  }

  /// `Fajr:Dhuhr:Asr:Maghrib:Isha`
  String get prayertime {
    return Intl.message(
      'Fajr:Dhuhr:Asr:Maghrib:Isha',
      name: 'prayertime',
      desc: 'Prayer times for Fajr, Dhuhr, Asr, Maghrib, and Isha',
      args: [],
    );
  }

  /// `Prayer is a light in darkness, a paradise in this world, and an intercessor on the Day of Judgment.`
  String get hekma {
    return Intl.message(
      'Prayer is a light in darkness, a paradise in this world, and an intercessor on the Day of Judgment.',
      name: 'hekma',
      desc: 'A wisdom quote related to prayer',
      args: [],
    );
  }

  /// `Prayer\nTimes`
  String get prayerTime {
    return Intl.message(
      'Prayer\nTimes',
      name: 'prayerTime',
      desc: 'Label for the prayer times screen',
      args: [],
    );
  }

  /// `Prayer times notifications`
  String get prayNotification {
    return Intl.message(
      'Prayer times notifications',
      name: 'prayNotification',
      desc: 'Label for prayer time notifications',
      args: [],
    );
  }

  /// `Last Read`
  String get lastRead {
    return Intl.message(
      'Last Read',
      name: 'lastRead',
      desc: 'Label for displaying the last read Quran verse or content',
      args: [],
    );
  }

  /// `Verse no : `
  String get verse {
    return Intl.message(
      'Verse no : ',
      name: 'verse',
      desc: 'Displays the current verse number',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
