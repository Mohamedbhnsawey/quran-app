import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quran2/bloc_observer.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/generated/l10n.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/style/themes.dart';
import 'package:quran2/view/home2.dart';
import 'package:quran2/view/notif.dart';
import 'package:provider/provider.dart';
import 'package:quran2/view/work_manager_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  final inits = <Future<dynamic>>[cashhelper.init(), LocalNotification.init()];
  if (!kIsWeb) {
    inits.add(WorkManagerService().init());
  }
  await Future.wait(inits);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // SystemChrome.setSystemUIOverlayStyle(
  //     const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  Qurancontroller()
                    ..loadJsonAsset(json: 'assets/json/names/surah.json')
                    ..loadJsonFiles()
                    ..cashsaved()
                    ..getAzkar(element: 'category')
                    ..enableWakeLock()
                    ..checkLocationPermission(),
        ),
        ChangeNotifierProvider(create: (context) => ThemeChanger()),
        ChangeNotifierProvider(create: (context) => MenuAppController()),
      ],
      child: BlocConsumer<Qurancontroller, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final themee = Provider.of<ThemeChanger>(context);
          return MaterialApp(
            locale: Locale(themee.lang),
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            theme: lighttt,
            darkTheme: darkkkkk,
            themeMode: themee.isDark ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: const Home2(),
          );
        },
      ),
    );
  }
}

class ThemeChanger with ChangeNotifier {
  bool isDark = cashhelper.getdata(key: 'mode') ?? false;
  String lang = cashhelper.getdata(key: 'language') ?? 'ar';
  void changeLang({required langg, required BuildContext context}) {
    lang = langg;
    cashhelper.savedata(key: 'language', value: langg);
    notifyListeners();
  }

  void changeTheme({required bool isdarkk}) {
    isDark = isdarkk;
    cashhelper.savedata(key: 'mode', value: isdarkk);
    notifyListeners();
  }
}

class MenuAppController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey;
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
  }
}
