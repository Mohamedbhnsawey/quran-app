import 'dart:math';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:provider/provider.dart';
import 'package:quran2/controller/quran/quran_controller.dart';
import 'package:quran2/controller/quran/quran_states.dart';
import 'package:quran2/main.dart';
import 'package:quran2/shared/components/constants.dart';

class Qibla extends StatelessWidget {
  const Qibla({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Qurancontroller()..getPermission(),
      child: BlocConsumer<Qurancontroller, QuranStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = Qurancontroller.get(context);

          return ConditionalBuilder(
            condition: true,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) {
              return Scaffold(
                  // backgroundColor: Colors.black,
                  body: FutureBuilder(
                future: cubit.getPermission(),
                builder: (context, snapshot) {
                  if (cubit.hasPermission) {
                    return const QiblahScreen();
                  } else {
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ));
            },
          );
        },
      ),
    );
  }
}

class QiblahScreen extends StatefulWidget {
  const QiblahScreen({super.key});

  @override
  State<QiblahScreen> createState() => _QiblahScreenState();
}

Animation<double>? animation;
AnimationController? _animationController;
double begin = 0.0;

class _QiblahScreenState extends State<QiblahScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween(begin: 0.0, end: 0.0).animate(_animationController!);
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themee = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
          //automaticallyImplyLeading: false,

          title: const Text(
            'القبلة',
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
              ))),
      body: StreamBuilder(
        stream: FlutterQiblah.qiblahStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                ));
          }

          final qiblahDirection = snapshot.data;
          animation = Tween(
                  begin: begin,
                  end: (qiblahDirection!.qiblah * (pi / 180) * -1))
              .animate(_animationController!);
          begin = (qiblahDirection.qiblah * (pi / 180) * -1);
          _animationController!.forward(from: 0);

          return Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "${qiblahDirection.direction.toInt()}°",
                style: TextStyle(
                    color: themee.isDark ? Colors.white : QuranSecondaryColor,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 300,
                  child: AnimatedBuilder(
                    animation: animation!,
                    builder: (context, child) => Transform.rotate(
                        angle: animation!.value,
                        child: Image.asset('assets/images/qibla.png')),
                  ))
            ]),
          );
        },
      ),
    );
  }
}
