import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart' as k;
import 'package:jhijri/_src/_jHijri.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/generated/l10n.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/components/widget.dart';
import 'package:quran2/view/azkar.dart';
import 'package:quran2/view/home.dart';
import 'package:quran2/view/prayer_time.dart';
import 'package:quran2/view/qibla.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.themee,
    required this.scaffoldKey,
  });

  final ThemeChanger themee;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          themee.isDark
              ? const Color.fromARGB(150, 41, 52, 61)
              : QuranPrimaryColor,
      title: const Text("My Quran", style: TextStyle(color: Colors.white)),
      leading: IconButton(
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
        },
        icon: const Icon(Icons.menu_rounded, color: Colors.white),
      ),
    );
  }
}

class QuranDrawer extends StatelessWidget {
  const QuranDrawer({super.key, required this.cubit, required this.themee});

  final Qurancontroller cubit;
  final ThemeChanger themee;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DrawerTitel(titel: '  ${S.of(context).language}  '),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DrawerLang(
                      themee: themee,
                      onPressed: () {
                        cubit.changeDrawerLang(index: 0);
                        themee.changeLang(langg: "ar", context: context);
                        cubit.cashsaved();
                      },
                      color:
                          cubit.drawerLang == 0
                              ? themee.isDark
                                  ? Colors.grey
                                  : QuranSecondaryColor
                              : null,
                      text: 'العربية',
                    ),
                    DrawerLang(
                      themee: themee,
                      onPressed: () {
                        cubit.changeDrawerLang(index: 1);
                        themee.changeLang(langg: "en", context: context);
                        cubit.cashsaved();
                      },
                      color:
                          cubit.drawerLang == 1
                              ? themee.isDark
                                  ? Colors.grey
                                  : QuranSecondaryColor
                              : null,
                      text: 'English',
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DrawerTitel(titel: '  ${S.of(context).mode}  '),
                const SizedBox(height: 10),
                Row(
                  children: [
                    DrawerMode(
                      cubit: themee,
                      onPressed: () {
                        cubit.changeDrawerMode(index: 0, isDarkk: false);
                        themee.changeTheme(isdarkk: false);
                      },
                      color:
                          cubit.drawerMode == 0
                              ? themee.isDark
                                  ? Colors.grey
                                  : QuranSecondaryColor
                              : null,
                      icon: Icons.light_mode_outlined,
                    ),
                    DrawerMode(
                      cubit: themee,
                      onPressed: () {
                        cubit.changeDrawerMode(index: 1, isDarkk: true);
                        themee.changeTheme(isdarkk: true);
                      },
                      color:
                          cubit.drawerMode == 1
                              ? themee.isDark
                                  ? Colors.grey
                                  : QuranSecondaryColor
                              : null,
                      icon: Icons.dark_mode_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DrawerTitel(titel: '  ${S.of(context).FontSize}  '),
                Row(
                  children: [
                    Text(S.of(context).A, style: const TextStyle(fontSize: 12)),
                    Expanded(
                      child: Slider(
                        //inactiveColor: Colors.blue,
                        activeColor:
                            themee.isDark ? Colors.white : QuranSecondaryColor,
                        min: 12,
                        max: 32,
                        value: fontsize,
                        onChanged: (value) {
                          cubit.changeDrawerFontSize(index: value);
                        },
                      ),
                    ),
                    Text(S.of(context).A, style: const TextStyle(fontSize: 32)),
                  ],
                ),
                const SizedBox(height: 10),
                DrawerTitel(titel: '  ${S.of(context).reading}  '),
                DrawerCheckBox(
                  themee: themee,
                  onChanged: (p0) {
                    cubit.changeDrawerScreenTime(checked: p0!);
                  },
                  cubit: cubit,
                  txt: S.of(context).keepScreen,
                  value: cubit.drawerScreenTime,
                ),
                const SizedBox(height: 10),
                DrawerCheckBox(
                  themee: themee,
                  onChanged: (p0) {
                    cubit.changeDrawerShowClock(checked: p0!);
                  },
                  cubit: cubit,
                  txt: S.of(context).ShowClock,
                  value: showclock,
                ),
                const SizedBox(height: 10),
                DrawerTitel(titel: '  ${S.of(context).notification}  '),
                const SizedBox(height: 10),
                DrawerCheckBox(
                  themee: themee,
                  onChanged: (p0) {
                    // cubit.changeDrawerScreenTime(checked: p0!);
                  },
                  cubit: cubit,
                  txt: S.of(context).kahfNotification,
                  value: false,
                ),
                const SizedBox(height: 10),
                DrawerCheckBox(
                  themee: themee,
                  onChanged: (p0) {
                    // cubit.changeDrawerShowClock(checked: p0!);
                  },
                  cubit: cubit,
                  txt: S.of(context).prayNotification,
                  value: false,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerCheckBox extends StatelessWidget {
  const DrawerCheckBox({
    super.key,
    required this.cubit,
    required this.themee,
    required this.txt,
    required this.value,
    required this.onChanged,
  });
  final ThemeChanger themee;
  final Qurancontroller cubit;
  final String txt;
  final bool value;

  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            activeColor: themee.isDark ? Colors.white : QuranSecondaryColor,
            checkColor: themee.isDark ? Colors.black : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3)),
            ),
            value: value,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Text(maxLines: 2, txt, style: const TextStyle(fontSize: 18.0)),
        ),
      ],
    );
  }
}

class DrawerTitel extends StatelessWidget {
  final String titel;
  const DrawerTitel({super.key, required this.titel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Expanded(child: Divider()),
        Text(titel),
        const Expanded(child: Divider()),
      ],
    );
  }
}

class DrawerLang extends StatelessWidget {
  final String text;
  final dynamic color;
  final ThemeChanger themee;
  final void Function()? onPressed;

  const DrawerLang({
    super.key,
    required this.text,
    this.color,
    required this.onPressed,
    required this.themee,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: TextButton(
          style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(Colors.transparent),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              color: themee.isDark ? Colors.white : Colors.black,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    );
  }
}

class choices extends StatelessWidget {
  const choices({
    super.key,
    required this.fontSize,
    required this.cubit,
    required this.themee,
    required this.text,
    required this.show,
    required this.asset,
    this.onTap,
  });

  final double fontSize;
  final String text;
  final bool show;
  final ThemeChanger themee;
  final String asset;
  final VoidCallback? onTap;
  final Qurancontroller cubit;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color:
                themee.isDark
                    ? const Color.fromARGB(150, 41, 52, 61)
                    : primaryColor2,
            borderRadius: const BorderRadius.all(Radius.circular(25)),
          ),
          //height: 140,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: fontSize / 17,
                  color: Colors.white,
                  fontFamily: 'almawadah',
                ),
              ),
              if (show) const Text(""),
              SvgPicture.asset(
                width: 50,
                height: 50,
                asset,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerMode extends StatelessWidget {
  final IconData icon;
  final dynamic color;
  final void Function()? onPressed;
  final ThemeChanger cubit;

  const DrawerMode({
    super.key,
    required this.icon,
    this.color,
    required this.onPressed,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
        ),
        child: IconButton(
          // style: ButtonStyle(
          //   overlayColor: WidgetStateProperty.all(Colors.transparent),
          // ),
          onPressed: onPressed,
          icon: Icon(icon, color: cubit.isDark ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}

Container dateTimeWidgit(ThemeChanger themee, double fontSize) {
  return Container(
    padding: const EdgeInsets.all(10),
    width: double.infinity,
    //height: size.height * .25,
    decoration: BoxDecoration(
      color:
          themee.isDark ? const Color.fromARGB(150, 41, 52, 61) : primaryColor2,
    ),
    child: Column(
      children: [
        StreamBuilder(
          stream: Stream.periodic(const Duration(minutes: 1)),
          builder: (context, snapshot) {
            return Text(
              "${k.DateFormat('hh').format(DateTime.now()).toString()}:${k.DateFormat('mm').format(DateTime.now()).toString()}",
              style: TextStyle(
                fontSize: fontSize / 8,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
        themee.lang == 'ar'
            ? Text(
              "${JHijri.now().day.toString()} ${JHijri.now().monthName} ${JHijri.now().year.toString()} هـ",
              style: TextStyle(
                fontSize: fontSize / 15,
                color: Colors.white,
                fontFamily: 'almawadah',
              ),
            )
            : Text(
              "${DateTime.now().day} ${englishHMonth(JHijri.now().month)} ${JHijri.now().year.toString()} AH",
              style: TextStyle(fontSize: fontSize / 20, color: Colors.white),
            ),
      ],
    ),
  );
}

class HomeComponents extends StatelessWidget {
  const HomeComponents({
    super.key,
    required this.themee,
    required this.cubit,
    required this.fontSize,
  });

  final ThemeChanger themee;
  final Qurancontroller cubit;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      //height: size.height * .63,
      decoration: BoxDecoration(
        color:
            themee.isDark
                ? const Color(0xFF1E2025)
                : const Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          Row(
            spacing: 20,
            children: [
              choices(
                themee: themee,
                cubit: cubit,
                onTap: () {
                  navigateTO(context, const Home());
                },
                fontSize: fontSize,
                asset: "assets/icons/koran.svg",
                text: S.of(context).quran,
                show: true,
              ),

              choices(
                themee: themee,
                cubit: cubit,
                show: true,
                onTap: () {
                  navigateTO(context, const Azkar());
                },
                fontSize: fontSize,
                text: S.of(context).athkar,
                asset: "assets/icons/beads.svg",
              ),
            ],
          ),

          Row(
            spacing: 20,
            children: [
              choices(
                themee: themee,
                cubit: cubit,
                show: false,
                onTap: () {
                  cubit.calculatePrayerTimes();
                  navigateTO(context, const PrayerTime());
                },
                fontSize: fontSize,
                asset: "assets/icons/clock.svg",
                text: S.of(context).prayerTime,
              ),

              choices(
                themee: themee,
                cubit: cubit,
                show: true,
                onTap: () {
                  navigateTO(context, const Qibla());
                },
                fontSize: fontSize,
                text: S.of(context).qibla,
                asset: "assets/icons/location.svg",
              ),
            ],
          ),
        ],
      ),
    );
  }
}


//
// [
//   true,
//   true,
//   false,
//   true,
// ],
// [
//   Home(),
//    Azkar(),
//    PrayerTime(),
//    Qibla()

// ],
//  [ "assets/icons/koran.svg",
//   "assets/icons/beads.svg",
//   "assets/icons/clock.svg",
//   "assets/icons/location.svg",]
//   ,
//   [
//   "S.of(context).quran",
//   "S.of(context).athkar",
//   "S.of(context).prayerTime,",
//   "S.of(context).location,"
//   ]
// ];