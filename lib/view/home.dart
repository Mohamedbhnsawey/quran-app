// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/generated/l10n.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/quran_widget.dart';
import 'package:quran2/shared/components/widget.dart';
import 'package:quran2/view/home2.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final themee = Provider.of<ThemeChanger>(context);
    return BlocConsumer<Qurancontroller, QuranStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = Qurancontroller.get(context);
        return Scaffold(
            // extendBodyBehindAppBar: true,

            // backgroundColor:
            //     themee.isDark ? QuranDarkSecondaryColor : Colors.white,
            appBar: AppBar(
              //backgroundColor: Colors.transparent,
              //surfaceTintColor: Colors.transparent,
              // centerTitle: true,
              //titleSpacing: 70,
              leading: IconButton(
                  onPressed: () {
                    navigateTO(context, const Home2());
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded)),
              title: Text(
                S.of(context).quran,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      cubit.showSearchField();
                    },
                    icon: const Icon(
                      Icons.search,
                    ))
              ],
            ),
            body: QuranBody(cubit: cubit, themee: themee, size: size));
      },
    );
  }
}

