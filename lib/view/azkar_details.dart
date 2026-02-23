import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/components/widget.dart';
import 'package:quran2/view/azkar.dart';

class AzkarDetails extends StatelessWidget {
  final List<dynamic> azkar;
  final String name;
  const AzkarDetails({super.key, required this.azkar, required this.name});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Qurancontroller, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Qurancontroller.get(context);
        final themee = Provider.of<ThemeChanger>(context);
        return ConditionalBuilder(
          condition: azkar.isNotEmpty,
          fallback: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
          builder: (context) {
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  title: Text(
                    name,
                    style: TextStyle(
                      color: themee.isDark ? Colors.white : QuranSecondaryColor,
                    ),
                  ),
                  leading: Padding(
                    padding: const EdgeInsets.only(
                      right: 20,
                    ),
                    child: IconButton(
                      iconSize: 16,
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                      ), // Adjust icon and color as needed
                      onPressed: () {
                        navigateTO(context, const Azkar());
                        // Handle back button press
                      },
                    ),
                  ),
                ),
                // backgroundColor: Color.fromARGB(150, 217, 224, 173),
                body: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemCount: azkar.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 10,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        cubit.azkartap(
                                            azkarlength: azkar.length,
                                            index: index);
                                        //print(cubit.zeros);
                                        if (int.parse(azkar[index]['count']) ==
                                                cubit.zeros[index] ||
                                            azkar[index]['count'] == "") {
                                          // test = true;
                                          if (azkar.length >= 2) {
                                            azkar.removeAt(index);
                                            cubit.zeros[index] = 0;
                                          } else {
                                            Navigator.pop(context);
                                          }

                                          //cubit.zeros.removeAt(index);

                                          cubit.removeAzkar();
                                        }
                                      },
                                      child: Container(
                                        width: double
                                            .infinity, // Fills the entire screen width
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: themee.isDark
                                              ? QuranDarkPrimaryColor
                                              : const Color.fromARGB(
                                                  30,
                                                  142,
                                                  182,
                                                  155), // Set your desired background color
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Add border radius
                                          // boxShadow: [
                                          //   BoxShadow(
                                          //     color: Colors.grey.withOpacity(
                                          //         .3), // Set shadow color
                                          //     // spreadRadius: 5,
                                          //     blurRadius: 7,

                                          //     offset: const Offset(0.0,
                                          //         2.0), // Set shadow offset
                                          //   )
                                          // ],
                                        ), // Set your desired height
                                        child: Text(
                                          textAlign: TextAlign.justify,
                                          azkar[index]['zekr'],
                                          style: TextStyle(
                                            height: 2,
                                            wordSpacing: 1.2,
                                            fontSize: fontsize,
                                            //fontWeight: FontWeight.bold,
                                            color: themee.isDark
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                  backgroundColor: themee.isDark
                                                      ? QuranDarkSecondaryColor
                                                      : Colors.white,
                                                  scrollable: true,

                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                  ),
                                                  //title: Text("title"),
                                                  content: Column(
                                                    mainAxisSize: MainAxisSize
                                                        .min, // Wrap content vertically
                                                    children: [
                                                      Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        azkar[index]
                                                            ['description'],
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                      const Divider(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          TextButton(
                                                            onPressed: () =>
                                                                Navigator.pop(
                                                                    context), // Close the dialog
                                                            child: Text(
                                                                style: TextStyle(
                                                                    color: themee
                                                                            .isDark
                                                                        ? Colors
                                                                            .white
                                                                        : QuranSecondaryColor,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                                'OK'),
                                                          ),
                                                        ],
                                                      ),
                                                      // Add a horizontal line
                                                    ],
                                                  ),
                                                  //actions: [],
                                                ),
                                              );
                                            },
                                            icon: const Icon(
                                              Icons.info_outline,
                                            )),
                                        const Spacer(),
                                        Text(
                                          azkar[index]['count'] ==
                                                      1.toString() ||
                                                  azkar[index]['count'] == ""
                                              ? '١ مرة'
                                              : "${cubit.convertToArabicNumber(azkar[index]['count'])} مرات/ ${cubit.convertToArabicNumber(cubit.zeros.isEmpty ? "0" : "${cubit.zeros[index]}")}",
                                          style: TextStyle(
                                              color: themee.isDark
                                                  ? Colors.white
                                                  : QuranSecondaryColor,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'AmiriQuran'),
                                        )
                                      ],
                                    )
                                  ],
                                );
                              },
                            ),
                          )
                        ],
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
