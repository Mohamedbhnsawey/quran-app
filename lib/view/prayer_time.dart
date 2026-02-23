// ignore_for_file: camel_case_types

import 'package:adhan/adhan.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/generated/l10n.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';

class PrayerTime extends StatelessWidget {
  const PrayerTime({super.key});

  // Check and request location permission

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<Qurancontroller, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Qurancontroller.get(context);
        final themee = Provider.of<ThemeChanger>(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              S.of(context).prayerTime,
              style: const TextStyle(fontSize: 20),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_forward_ios_rounded),
              ),
            ],
          ),

          //backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(
                condition: cubit.prayTimes!.isNotEmpty,
                fallback:
                    (context) =>
                        const Center(child: CircularProgressIndicator()),
                builder:
                    (context) => Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                //height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors:
                                        themee.isDark
                                            ? [
                                              const Color(0xFF3C5665),
                                              const Color(0xFF5A7480),
                                              const Color(0xFF92A4B1),
                                            ]
                                            : [
                                              QuranPrimaryColor,
                                              QuranSecondaryColor,
                                              const Color(0xFFDAF1DE),
                                            ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).currentPray,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                      ),
                                    ),
                                    Text(
                                      cubit.getLocal() == 'ar'
                                          ? cubit.getCurrentAndNextPray(
                                            pray:
                                                "${prayerTime!.currentPrayer()}",
                                          )
                                          : "${prayerTime!.currentPrayer()}"
                                              .substring(7),
                                      style: TextStyle(
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                        fontSize: size.width / 20,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            themee.isDark
                                                ? const Color(0xFF07142B)
                                                : QuranPrimaryColor,
                                      ),
                                    ),
                                    Text(
                                      cubit.getLocal() == 'ar'
                                          ? cubit.currentPrayerTime
                                              .replaceFirst("AM", "ص")
                                              .replaceFirst("PM", "م")
                                          : cubit.currentPrayerTime,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                        fontSize: size.width / 20,
                                      ),
                                    ),
                                    Text(
                                      prayerTime!.currentPrayer() !=
                                              Prayer.sunrise
                                          ? cubit.getLocal() == 'ar'
                                              ? "${S.of(context).azan} - ${cubit.currentPrayerTime}"
                                                  .replaceFirst("AM", "ص")
                                                  .replaceFirst("PM", "م")
                                              : "${S.of(context).azan} - ${cubit.currentPrayerTime}"
                                          : "--",
                                      style: TextStyle(
                                        fontSize: size.width / 24,
                                        color: Colors.white,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                      ),
                                    ),
                                    Text(
                                      prayerTime!.currentPrayer() !=
                                              Prayer.sunrise
                                          ? cubit.getLocal() == 'ar'
                                              ? "${S.of(context).eqama} - ${cubit.eqamaTime}"
                                                  .replaceFirst("AM", "ص")
                                                  .replaceFirst("PM", "م")
                                              : "${S.of(context).eqama} - ${cubit.eqamaTime}"
                                          : "--",
                                      style: TextStyle(
                                        fontSize: size.width / 24,
                                        color: Colors.white,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(15),
                                //height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomRight,
                                    end: Alignment.topLeft,
                                    colors:
                                        themee.isDark
                                            ? [
                                              const Color(0xFF07142B),
                                              const Color(0xFF173C4C),
                                              const Color(0xFF326D6C),
                                            ]
                                            : [
                                              const Color(0xFFA4AC86),
                                              const Color(0xFFC2C5AA),
                                              const Color(0xFFB6AD90),
                                            ],
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      S.of(context).nextPray,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                      ),
                                    ),
                                    Text(
                                      cubit.getLocal() == 'ar'
                                          ? cubit.getCurrentAndNextPray(
                                            pray: "${prayerTime!.nextPrayer()}",
                                          )
                                          : "${prayerTime!.nextPrayer()}"
                                              .substring(7),
                                      style: TextStyle(
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? "almawadah"
                                                : "gilroy",
                                        fontSize: size.width / 24,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            themee.isDark
                                                ? const Color(0xFF92A4B1)
                                                : primaryColor2,
                                      ),
                                    ),
                                    Text(
                                      cubit.getLocal() == 'ar'
                                          ? cubit.nextPrayerTime
                                              .replaceFirst("PM", "م")
                                              .replaceFirst("AM", "ص")
                                          : cubit.nextPrayerTime,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily:
                                            cubit.getLocal() == 'ar'
                                                ? 'almawadah'
                                                : 'gilroy',
                                        fontSize: size.width / 20,
                                      ),
                                    ),
                                    const Text(""),
                                    const Text(""),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            //height: 400,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(25),
                              ),
                              color:
                                  themee.isDark
                                      ? QuranDarkPrimaryColor
                                      : const Color.fromARGB(30, 142, 182, 155),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).hekma,
                                  style: TextStyle(
                                    fontFamily:
                                        cubit.getLocal() == 'ar'
                                            ? "almawadah"
                                            : "gilroy",
                                    fontSize: size.width / 30,
                                    color:
                                        themee.isDark
                                            ? Colors.white
                                            : QuranSecondaryColor,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...List.generate(5, (index) {
                                  return Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/athores/pray${index + 1}.svg",
                                              width: size.width / 15,
                                              height: size.width / 15,
                                              fit: BoxFit.cover,
                                              colorFilter:
                                                  const ColorFilter.mode(
                                                    seconderyColor,
                                                    BlendMode.srcIn,
                                                  ),
                                            ),
                                            const SizedBox(width: 20),
                                            Text(
                                              S
                                                  .of(context)
                                                  .prayertime
                                                  .split(":")[index],
                                              style: TextStyle(
                                                fontFamily: 'almawadah',
                                                // color: Colors.white,
                                                fontSize: size.width / 15,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              cubit.getLocal() == 'ar'
                                                  ? "${cubit.prayTimes![index]}"
                                                      .replaceFirst('AM', 'ص')
                                                      .replaceFirst("PM", 'م')
                                                  : "${cubit.prayTimes![index]}",
                                              style: TextStyle(
                                                fontFamily:
                                                    cubit.getLocal() == 'ar'
                                                        ? 'almawadah'
                                                        : "gilroy",
                                                //color: Colors.white,
                                                fontSize: size.width / 15,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Divider(
                                          color: Color.fromARGB(
                                            50,
                                            17,
                                            111,
                                            148,
                                          ),
                                          height: 2,
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
              ),
            ),
          ),
        );
      },
    );
  }
}
