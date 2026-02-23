import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran2/controller/quran/quran_controller.dart';

void navigateTO(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
void navigateandfinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (route) => false,
    );

Widget txtformfield(
        {required void Function()? onTap,
        required void Function(String)? onChanged,
        required Color color,
        required String hint,
        required TextEditingController? searchController}) =>
    SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        controller: searchController,
        onTap: onTap,
        // style: const TextStyle(
        //     // color: Colors.white, // Change the color here
        //     ),
        decoration: InputDecoration(
            filled: true, // This enables the fill color
            //fillColor: const Color.fromARGB(40, 158, 158, 158),

            // hintStyle: const TextStyle(
            //     color: Colors.grey,
            //     ),
            hintText: hint,
            hintStyle: TextStyle(color: color),
            border: InputBorder.none),
      ),
    );

class AyahNum extends StatelessWidget {
  const AyahNum(
      {super.key,
      required this.cubit,
      required this.color,
      required this.assete,
      required this.fontsize,
      required this.num,
      required this.width});
  final String num;

  final Qurancontroller cubit;
  final double width;
  final double fontsize;
  final String assete;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SvgPicture.asset(
        width: width,
        fit: BoxFit.fitWidth,
        assete,
        //colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      ),
      Text(
        num,
        style: TextStyle(
          color: color,
          fontSize: fontsize,
          fontWeight: FontWeight.bold,
        ),
      ),
    ]);
  }
}

class SurahNum extends StatelessWidget {
  const SurahNum(
      {super.key,
      required this.color,
      required this.cubit,
      required this.fontsize,
      required this.num,
      required this.width});
  final String num;
  final Color color;
  final Qurancontroller cubit;
  final double width;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.center, children: [
      SizedBox(
        child: SvgPicture.asset(
          width: width,
          fit: BoxFit.fitWidth,
          "assets/icons/ayah2.svg",
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
      Text(
        num,
        style: TextStyle(
            color: color,
            fontSize: fontsize,
            fontWeight: FontWeight.bold,
            fontFamily: cubit.getLocal() == 'ar' ? 'almawadah' : 'gilory'),
      ),
    ]);
  }
}
