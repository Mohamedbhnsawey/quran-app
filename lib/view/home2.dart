// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';
import 'package:quran2/shared/components/home_widget.dart';

class Home2 extends StatelessWidget {
  const Home2({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    double fontSize = MediaQuery.of(context).size.width;
    return Provider(
      create: (context) => Qurancontroller(),
      child: BlocConsumer<Qurancontroller, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final themee = Provider.of<ThemeChanger>(context);
          var cubit = Qurancontroller.get(context);
          return Scaffold(
            appBar: HomeAppBar(themee: themee, scaffoldKey: scaffoldKey),
            key: scaffoldKey,
            drawer: QuranDrawer(cubit: cubit, themee: themee),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  dateTimeWidgit(themee, fontSize),
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color:
                          themee.isDark
                              ? const Color.fromARGB(150, 41, 52, 61)
                              : primaryColor2,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                      ),
                    ),
                  ),
                  HomeComponents(
                    themee: themee,
                    cubit: cubit,
                    fontSize: fontSize,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
