// ignore_for_file: camel_case_types

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/components/widget.dart';

double _getYOffsetOf(GlobalKey key) {
  final box = key.currentContext!.findRenderObject() as RenderBox;

  return box.localToGlobal(Offset.zero).dy;
}

double _getXOffsetOf(GlobalKey key) {
  final box = key.currentContext!.findRenderObject() as RenderBox;
  return box.localToGlobal(Offset.zero).dx;
}

void _resolveSameRow(List<GlobalKey<_WidgetSpanWrapperState>> keys) {
  var middle = (keys.length / 2.0).floor();
  for (int i = 0; i < middle; i++) {
    var a = keys[i];
    var b = keys[keys.length - i - 1];
    var left = _getXOffsetOf(a);
    var right = _getXOffsetOf(b);
    a.currentState!.updateXOffset(right - left);
    b.currentState!.updateXOffset(left - right);
  }
}

class Surah extends StatelessWidget {
  final String nameEn;
  final String nameAr;
  final int index;
  //final List<List<dynamic>> data;

  const Surah({
    super.key,
    required this.nameEn,
    required this.nameAr,
    required this.index,
    // required this.data,
    // required this.dataa,
  });

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    final themee = Provider.of<ThemeChanger>(context);
// Extract verse number
// Extract verse number
    final keys = <GlobalKey<_WidgetSpanWrapperState>>[];
    nextKey() {
      var key = GlobalKey<_WidgetSpanWrapperState>();
      keys.add(key);
      return key;
    }

    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      List<GlobalKey<_WidgetSpanWrapperState>>? sameRow;
      GlobalKey<_WidgetSpanWrapperState> prev = keys.removeAt(0);
      for (var key in keys) {
        if (_getYOffsetOf(key) == _getYOffsetOf(prev)) {
          sameRow ??= [prev];
          sameRow.add(key);
        } else if (sameRow != null) {
          _resolveSameRow(sameRow);
          sameRow = null;
        }
        prev = key;
      }
      if (sameRow != null) {
        _resolveSameRow(sameRow);
      }
    });
    return BlocConsumer<Qurancontroller, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Qurancontroller.get(context);
        var size = MediaQuery.of(context).size;
        return ConditionalBuilder(
          condition: cubit.jsonDataMap.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            Map<String, dynamic> verse = cubit.jsonDataMap["verse"];
            //final verseNumber = verse.entries.toList();
            return Scaffold(
                backgroundColor:
                    themee.isDark ? QuranDarkSecondaryColor : Colors.white,
                body: SafeArea(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.topCenter,
                              children: [
                              SvgPicture.asset(
                                fit: BoxFit.fitWidth,
                                themee.isDark
                                    ? "assets/icons/surahName.svg"
                                    : 'assets/icons/surah_banner.svg',
                              ),
                              Center(
                                child: Text(
                                  nameAr,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      //letterSpacing: 3,
                                      color: Colors.black,
                                      fontFamily: 'AmiriQuran'),
                                ),
                              )
                            ]),
                            //suraName(cubit),
                            const SizedBox(
                              height: 10,
                            ),
                            SvgPicture.asset(
                              "assets/icons/allah.svg",
                              colorFilter: ColorFilter.mode(
                                  themee.isDark ? Colors.white : Colors.black,
                                  BlendMode.srcIn),
                            ),
                            RichText(
                              textAlign: TextAlign.justify,
                              locale: const Locale("ar"),
                              textDirection: TextDirection.rtl,
                              text: TextSpan(
                                children: verse.entries.skip(1).map((txt) {
                                  final verseNumber = txt.key
                                      .substring(6); // Extract verse number
                                  final verseText = txt.value;
                                  return TextSpan(
                                    children: [
                                      TextSpan(
                                        onEnter: (event) {},
                                        // mouseCursor:
                                        //     SystemMouseCursors.text,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            cubit.jsonData.isNotEmpty
                                                ? showDialog(
                                                    context: context,
                                                    builder:
                                                        (context) => Column(
                                                              children: [
                                                                Dialog(
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  insetPadding:
                                                                      EdgeInsets.only(
                                                                          top: size.height -
                                                                              400),
                                                                  clipBehavior:
                                                                      Clip.antiAliasWithSaveLayer,
                                                                  child: Builder(
                                                                      builder:
                                                                          (context) {
                                                                    return Container(
                                                                      decoration:
                                                                          const BoxDecoration(

                                                                              //color: Colors.white
                                                                              ),
                                                                      width: 70,
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .all(
                                                                              8),
                                                                      child:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          // print(nameAr);
                                                                          // print(nameEn);
                                                                          // print(verseNumber);
                                                                          // print(cubit.convertToArabicNumber(verseNumber));
                                                                          cashhelper.savedata(
                                                                              key: 'surah_en',
                                                                              value: nameEn);
                                                                          cashhelper.savedata(
                                                                              key: 'aya_ar',
                                                                              value: cubit.convertToArabicNumber(verseNumber));
                                                                          cashhelper.savedata(
                                                                              key: 'surah_ar',
                                                                              value: nameAr);
                                                                          cashhelper.savedata(
                                                                              key: 'aya_en',
                                                                              value: verseNumber);
                                                                          cubit
                                                                              .cashsaved();
                                                                        },
                                                                        child:
                                                                            const Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(
                                                                              Icons.bookmark,
                                                                              color: primaryColor2,
                                                                            ),
                                                                            SizedBox(
                                                                              width: 8,
                                                                            ),
                                                                            Text(
                                                                              "إشارة مرجعية",
                                                                              style: TextStyle(color: Colors.white),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }),
                                                                ),
                                                                SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: List
                                                                        .generate(
                                                                      4,
                                                                      (indexx) {
                                                                        return Directionality(
                                                                          textDirection:
                                                                              TextDirection.rtl,
                                                                          child:
                                                                              AlertDialog(
                                                                            insetPadding:
                                                                                const EdgeInsets.only(left: 15, right: 0),
                                                                            scrollable:
                                                                                true,
                                                                            elevation:
                                                                                30,

                                                                            title:
                                                                                Text(cubit.quran[indexx]),
                                                                            titleTextStyle: TextStyle(
                                                                                fontFamily: 'neckar',
                                                                                fontSize: 20,
                                                                                color: themee.isDark ? Colors.white : Colors.black),
                                                                            content:
                                                                                SingleChildScrollView(
                                                                              reverse: true,
                                                                              scrollDirection: Axis.horizontal, // Set horizontal scrolling
                                                                              child: SizedBox(
                                                                                  height: 200,
                                                                                  width: size.width * .7,
                                                                                  child: Text(
                                                                                    cubit.jsonData[indexx][index][int.parse(verseNumber) - 1]['text'] == '' ? "لا يوجد معلومات" : cubit.jsonData[indexx][index][int.parse(verseNumber) - 1]['text'],
                                                                                    style: const TextStyle(fontFamily: 'neckar', fontSize: 20),
                                                                                  )),
                                                                            ),
                                                                            // ... other properties
                                                                          ),
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                          },
                                        text: " $verseText ",
                                        style: TextStyle(
                                            fontSize: fontsize,
                                            color: themee.isDark
                                                ? Colors.white
                                                : Colors.black,
                                            fontFamily: 'AmiriQuran'),
                                      ),
                                      WidgetSpan(
                                        alignment: PlaceholderAlignment.middle,
                                          child: WidgetSpanWrapper(
                                              key: nextKey(),
                                              child: AyahNum(
                                                  color: themee.isDark
                                                      ? QuranDarkSecondaryColor
                                                      : QuranPrimaryColor,
                                                  assete: themee.isDark
                                                      ? "assets/icons/darkAyahNum.svg"
                                                      : "assets/icons/ayahnum.svg",
                                                  num:cubit.convertToArabicNumber(verseNumber),
                                                  cubit: cubit,
                                                  width: 30,
                                                  fontsize: 13)))
                                    ],
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}

class WidgetSpanWrapper extends StatefulWidget {
  const WidgetSpanWrapper({super.key, required this.child});

  final Widget child;

  @override
  State<WidgetSpanWrapper> createState() => _WidgetSpanWrapperState();
}

class _WidgetSpanWrapperState extends State<WidgetSpanWrapper> {
  Offset offset = Offset.zero;

  void updateXOffset(double xOffset) {
    setState(() {
      offset = Offset(xOffset, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: offset,
      child: widget.child,
    );
  }
}

class TestWidgetSpan extends StatelessWidget {
  final Color color;
  final int order;

  const TestWidgetSpan({super.key, required this.color, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.5),
      width: 40,
      child: Center(child: Text(order.toString())),
    );
  }
}
