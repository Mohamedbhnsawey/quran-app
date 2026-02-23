// ignore_for_file: prefer_const_constructors

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
import 'package:quran2/shared/components/home_widget.dart';
import 'package:quran2/shared/components/widget.dart';
import 'package:quran2/view/azkar_details.dart';
import 'package:quran2/view/home2.dart';

class Azkar extends StatelessWidget {
  const Azkar({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    var searchctr = TextEditingController();
    // var size = MediaQuery.of(context).size;
    return BlocConsumer<Qurancontroller, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Qurancontroller.get(context);
        final themee = Provider.of<ThemeChanger>(context);
        return ConditionalBuilder(
          condition: cubit.azkarModel.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                  backgroundColor:
                      themee.isDark ? QuranDarkPrimaryColor : QuranPrimaryColor,
                  automaticallyImplyLeading: false,
                  title: Text(
                    S.of(context).athkar,
                    style: TextStyle(color: Colors.white),
                  ),
                  actions: [
                    RawMaterialButton(
                      onPressed: () {
                        cubit.showSearchField();
                      },
                      elevation: 2.0,
                      fillColor: const Color.fromARGB(
                          30, 182, 206, 224), // Set background color

                      padding: EdgeInsets.all(11.0),
                      shape: CircleBorder(),
                      child: Icon(
                        color: Colors.white,
                        Icons.search_rounded,
                        size: 18.0,
                      ),
                    ),
                  ],
                  leading: IconButton(
                      onPressed: () {
                        navigateTO(context, Home2());
                      },
                      icon: Icon(
                        color: Colors.white,
                        Icons.arrow_back_ios_rounded,
                      ))),
              resizeToAvoidBottomInset: false,
              key: scaffoldKey,
              drawer: QuranDrawer(cubit: cubit, themee: themee),
              body: SafeArea(
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(children: [
                    Container(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      color: themee.isDark
                          ? QuranDarkPrimaryColor
                          : QuranPrimaryColor,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  child: Text(
                                "قائمة الأذكار",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFFFFFFFF),
                                    fontFamily: 'almawadah'),
                              )),
                              Expanded(
                                  child: SvgPicture.asset(
                                height: 70,
                                width: 70,
                                'assets/icons/download (2).svg',
                                colorFilter: themee.isDark
                                    ? ColorFilter.mode(const Color(0xFF92A4B1),
                                        BlendMode.srcIn)
                                    : null,
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: cubit.showSearch ? null : 10,
                      decoration: BoxDecoration(
                          color: themee.isDark
                              ? QuranDarkSecondaryColor
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: cubit.showSearch
                          ? txtformfield(
                              color: themee.isDark
                                  ? Colors.grey
                                  : QuranSecondaryColor,
                              hint: 'ابحث باسم الدعاء أو الذكر',
                              searchController: searchctr,
                              onChanged: (p0) {
                                cubit.onChanged(
                                  p0: p0,
                                ); // Output: [apple]
                              },
                              onTap: () {},
                            )
                          : null,
                    ),
                    Expanded(
                      child: Container(
                          //padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: themee.isDark
                                ? QuranDarkSecondaryColor
                                : Colors.white,
                          ),
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.searchData.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  cubit.categories.clear();
                                  //print(cubit.jsoncubit.searchDataList);
                                  cubit.extractCategories(
                                      element: cubit.searchData[index]);
                                  navigateTO(
                                      context,
                                      AzkarDetails(
                                          azkar: cubit.categories,
                                          name: cubit.searchData[index]));
                                },
                                child: Container(
                                  width: double
                                      .infinity, // Fills the entire screen width
                                  padding: EdgeInsets.all(10),
                                  // Set your desired height
                                  child: Text(
                                    cubit.searchData[index],
                                    style: TextStyle(
                                        fontSize: 20,
                                        //fontWeight: FontWeight.bold,
                                        color: themee.isDark
                                            ? const Color(0xFF92A4B1)
                                            : const Color(0xFF8EB69B),
                                        fontFamily: 'almawadah'),
                                  ),
                                ),
                              );
                            },
                          )),
                    )
                  ]),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
