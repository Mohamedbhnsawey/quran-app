import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/generated/l10n.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/components/widget.dart';
import 'package:quran2/view/surah.dart';

class QuranBody extends StatelessWidget {
  const QuranBody({
    super.key,
    required this.cubit,
    required this.themee,
    required this.size,
  });

  final Qurancontroller cubit;
  final ThemeChanger themee;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConditionalBuilder(
        condition: cubit.jsonDataList.isNotEmpty,
        fallback: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
        builder: (context) => Padding(
          padding:
              const EdgeInsets.only(right: 15, left: 15, bottom: 15),
          child: Stack(children: [
            Column(
              spacing: 20,
              children: [
                if (cubit.showSearch)
                  txtformfield(
                      color: themee.isDark
                          ? Colors.grey
                          : QuranSecondaryColor,
                      onTap: () {},
                      onChanged: (p0) {
                        cubit.surahSearch(p0: p0); // This will
                      },
                      hint: "",
                      searchController: cubit.surahctr),
               
                lastRead(
                  asset: themee.isDark
                      ? "assets/icons/Mousaf2.svg"
                      : "assets/icons/Mousaf1.svg",
                  size: size,
                  cubit: cubit,
                  context: context,
                  theme: themee,
                ),
                
                Expanded(
                  child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            navigateTO(
                                context,
                                Surah(
                                  index: index,
                                  nameEn:
                                      cubit.jsonDataListSearch[index]
                                          ["titleEn"],
                                  nameAr:
                                      cubit.jsonDataListSearch[index]
                                          ["titleAr"],
                                ));
                            cubit.loadJsonAsset(
                                json:
                                    "assets/json/QuranSuras/surah_${cubit.jsonDataListSearch[index]["index"]}.json");
                          },
                          child: Row(
                            children: [
                              SurahNum(
                                  cubit: cubit,
                                  width: size.width / 10,
                                  fontsize: size.width / 25,
                                  color: themee.isDark
                                      ? Colors.white
                                      : primaryColor2,
                                  num: cubit.jsonDataListSearch[index]
                                      ["index"]),
                              const SizedBox(
                                width: 10,
                              ),
                              if (cubit.getLocal() != 'ar')
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      cubit.jsonDataListSearch[index]
                                          ["title"],
                                      style: TextStyle(
                                          fontFamily: "gilroy",
                                          fontSize: size.width / 30,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          cubit
                                              .jsonDataListSearch[index]
                                                  ["place"]
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: seconderyColor,
                                              fontFamily: 'gilory',
                                              fontSize:
                                                  size.width / 40),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          "${cubit.jsonDataListSearch[index]["count"]} verses"
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: seconderyColor,
                                              fontSize:
                                                  size.width / 40),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              if (cubit.getLocal() == 'ar')
                                Text(
                                  textAlign: TextAlign.end,
                                  cubit.jsonDataListSearch[index]
                                      ["titleAr"],
                                  style: TextStyle(
                                      color: themee.isDark
                                          ? Colors.white
                                          : primaryColor2,
                                      fontSize: size.width / 20,
                                      fontFamily: "almawadah",
                                      fontWeight: FontWeight.w600),
                                ),
                              const Spacer(),
                              ColordIconButton(
                                color: themee.isDark
                                    ? QuranDarkPrimaryColor
                                    : QuranSecondaryColor,
                                icon: Icons.play_arrow,
                                onPressed: () {
                                  cubit.changeplayAudioIcon2(
                                      suraNum: "${index + 1}");
                                },
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const Divider(
                            color: Color.fromARGB(100, 135, 137, 163),
                          ),
                      itemCount: cubit.jsonDataListSearch.length),
                )
                // ...List.generate(
                //   cubit.jsonDataListSearch.length,
                //   (index) {
                //     return surah(
                //         theme: themee,
                //         size: size,
                //         data: cubit.data,
                //         cubit: cubit,
                //         context: context,
                //         index: index,
                //         surahnum: cubit.jsonDataListSearch[index]["index"],
                //         surahName: cubit.jsonDataListSearch[index]["title"],
                //         surahNameAr: cubit.jsonDataListSearch[index]
                //             ["titleAr"],
                //         surahPlace: cubit.jsonDataListSearch[index]
                //             ["place"],
                //         versesNum: cubit.jsonDataListSearch[index]
                //             ["count"]);
                //   },
                // )
              ],
            ),
            if (cubit.playAudioIcon2)
              Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: QuranPlayer(
                  cubit: cubit,
                  size: size,
                  themee: themee,
                ),
              )
          ]),
        ),
      ),
    );
  }
}

class lastRead extends StatelessWidget {
  const lastRead({
    super.key,
    required this.size,
    required this.asset,
    required this.cubit,
    required this.context,
    required this.theme,
  });

  final Size size;
  final String asset;
  final Qurancontroller cubit;
  final BuildContext context;
  final ThemeChanger theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 150,
      decoration: BoxDecoration(
          color: theme.isDark ? QuranDarkPrimaryColor : primaryColor2,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/qquran.svg",
                      colorFilter:
                          const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      width: size.width / 25,
                      height: size.width / 25,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      S.of(context).lastRead,
                      style: TextStyle(
                          fontFamily:
                              cubit.getLocal() == 'ar' ? "almawadah" : "",
                          color: Colors.white,
                          fontSize: size.width / 30),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  cubit.getLocal() == 'ar' ? cubit.surahAr! : cubit.surah!,
                  style: TextStyle(
                      fontFamily: cubit.getLocal() == 'ar' ? "almawadah" : "",
                      color: Colors.white,
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${S.of(context).verse}${cubit.aya}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width / 20,
                      fontFamily: cubit.getLocal() == 'ar' ? "almawadah" : "",
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            //color: Colors.yellow,
          )),
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: SvgPicture.asset(
                  asset,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}

class ColordIconButton extends StatelessWidget {
  const ColordIconButton(
      {super.key,
      required this.onPressed,
      required this.icon,
      required this.color});

  final void Function() onPressed;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: IconButton(
          padding: const EdgeInsets.all(0),
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: Colors.white,
          )),
    );
  }
}

class QuranPlayer extends StatelessWidget {
  const QuranPlayer({
    super.key,
    required this.cubit,
    required this.themee,
    required this.size,
  });

  final Qurancontroller cubit;
  final Size size;
  final ThemeChanger themee;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: themee.isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  )
                ],
          color: themee.isDark
              ? const Color.fromARGB(255, 41, 52, 61)
              : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),

      //height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            key: const Key('play_button'),
            onPressed: cubit.changeplayAudioIcon,
            icon: cubit.playAudioIcon
                ? const Icon(Icons.play_arrow)
                : const Icon(Icons.pause),
            color: themee.isDark ? Colors.white : Colors.black,
          ),
          IconButton(
            key: const Key('pause_button'),
            onPressed: () {
              cubit.closeAudio();
            },
            iconSize: size.width / 14,
            icon: const Icon(Icons.stop),
            color: themee.isDark ? Colors.white : Colors.black,
          ),
          const Spacer(),
          Text(
            "سورة ${cubit.jsonDataListSearch[cubit.suraindex]["titleAr"]}",
            style: TextStyle(fontFamily: 'neckar', fontSize: size.width / 25),
          ),
          IconButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(10.0))),
                  useRootNavigator: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.95, // Set height to 90%
                        child: FutureBuilder<dynamic>(
                          future: cubit.loadJsonReciters(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return SizedBox(
                                height: size.height * .9,
                                child: const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Center(
                                child: Text('Error: ${snapshot.error}'),
                              );
                            } else {
                              final data = snapshot.data;
                              return Column(
                                children: [
                                  Stack(
                                    fit: StackFit.loose,
                                    children: [
                                      const Align(
                                        alignment: Alignment.center,
                                        child: Text(
                                          'اسم القارئ',
                                          style: TextStyle(
                                              //color: Colors.blue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'anckar'),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(
                                            Icons.arrow_back_ios_rounded,
                                            //color: Colors.blue,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: IconButton(
                                          onPressed: () {
                                            cubit.showSearchField();
                                          },
                                          icon: const Icon(
                                            Icons.search,
                                            //color: Colors.blue,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  if (cubit.showSearch)
                                    txtformfield(
                                        color: themee.isDark
                                            ? Colors.grey
                                            : QuranSecondaryColor,
                                        hint: 'ابحث عن اسم القارئ',
                                        onTap: () {},
                                        onChanged: (p0) {},
                                        searchController: cubit.controller),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Expanded(
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const Divider(),
                                          itemCount: data.length,
                                          itemBuilder:
                                              (context, index) =>
                                                  Row(children: [
                                                    const Icon(
                                                      Icons
                                                          .person_outline_rounded,
                                                      size: 24,
                                                    ),
                                                    const SizedBox(
                                                      width: 15,
                                                    ),
                                                    Text(data[index]['name']),
                                                    const Spacer(),
                                                    ColordIconButton(
                                                      onPressed: () {
                                                        data[index]['moshaf'][0]['surah_list'].split(',')[
                                                                    cubit
                                                                        .suraindex] ==
                                                                "${cubit.suraindex + 1}"
                                                            ? cubit.changeplayAudioIcon2(
                                                                url: data[index]
                                                                        ['moshaf'][0]
                                                                    ['server'],
                                                                suraNum: cubit
                                                                    .generateNumbers(
                                                                        numm: cubit.suraindex +
                                                                            1))
                                                            : showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) =>
                                                                        AlertDialog(
                                                                          title:
                                                                              const Text('خطأ'),
                                                                          content:
                                                                              Text('عذراً، لم يتم العثور على تلاوة الشيخ ${data[index]['name']}لهذة السورة'),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'Cancel'),
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () => Navigator.pop(context, 'OK'),
                                                                              child: const Text('OK'),
                                                                            ),
                                                                          ],
                                                                        ));

                                                        //print(cubit.generateNumbers(numm: cubit.suraindex + 1));
                                                        Navigator.pop(context);
                                                      },
                                                      icon: Icons
                                                          .play_arrow_rounded,
                                                      color: themee.isDark
                                                          ? QuranDarkPrimaryColor
                                                          : QuranSecondaryColor,
                                                    ),
                                                  ])))
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.keyboard_arrow_up_rounded))
        ],
      ),
    );
  }
}
