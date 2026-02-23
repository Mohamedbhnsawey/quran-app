import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran2/shared/components/constants.dart';

// class MyMaterialColor extends MaterialColor {
//   MyMaterialColor(int value)
//       : super(value, {
//           50: const Color(0xFF512EA1), // Shade 50: 10% opacity
//           100: const Color(0xFFD9D9D9), // Shade 100: 20% opacity
//           200: const Color(0xFFC0C0C0), // Shade 200: 30% opacity
//           300: const Color(0xFFA9A9A9), // Shade 300: 40% opacity
//           400: const Color(0xFF929292), // Shade 400: 50% opacity
//           500:
//               const Color(0xFF7C7C7C), // Shade 500: 60% opacity (primary shade)
//           600: const Color(0xFF666666), // Shade 600: 70% opacity
//           700: const Color(0xFF4F4F4F), // Shade 700: 80% opacity
//           800: const Color(0xFF393939), // Shade 800: 90% opacity
//           900: const Color(0xFF222222), // Shade 900: 100% opacity
//         });
// }
ThemeData lighttt = ThemeData(
    fontFamily: 'gilroy',
    useMaterial3: true,
    brightness: Brightness.light,
    // primarySwatch: MaterialColor(primary, swatch),

    scaffoldBackgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
        focusColor: kprimaryColor,
        activeIndicatorBorder: const BorderSide(color: Colors.red),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: kprimaryColor,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.redAccent,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.orangeAccent,
            width: 1,
          ),
        ),
        alignLabelWithHint: true,
        filled: true,
        //outlineBorder: BorderSide(color: Colors.green),
        //counterStyle: TextStyle(color: Colors.redAccent),
        //border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
        labelStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 73, 73, 73)),
        floatingLabelStyle: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: kprimaryColor),
        // disabledBorder: OutlineInputBorder(
        //           borderSide: BorderSide(
        //             color: Colors.blueGrey,
        //             width: 1,
        //           ),
        //         ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        fillColor: Colors.white),
    //focusColor: Colors.orange,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
            fontFamily: "almawadah",
            color: QuranSecondaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(
          color: Colors.black,
        )),


    textTheme: TextTheme(
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyMedium: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 5, 5, 5)),
      bodyLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 73, 73, 73)),
      bodySmall: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 3, 3, 3)),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[300]),
      labelLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
      labelMedium: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 73, 73, 73)),
      displayMedium: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 0, 0, 0)),
      displayLarge: const TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF006AD7)),
      displaySmall: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
    ),
    iconTheme: const IconThemeData(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconSize: WidgetStatePropertyAll(24),
            iconColor: WidgetStatePropertyAll(QuranSecondaryColor))),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
      elevation: 16,

      ),
      );
ThemeData darkkkkk = ThemeData(
    inputDecorationTheme:
        const InputDecorationTheme(fillColor: Color(0xFF1B1D21)),
    //primaryColor:Colors.blue,
    fontFamily: 'gilroy',
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: QuranDarkSecondaryColor,
    //primarySwatch: Colors.orange,
    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //   backgroundColor: primaryColor,
    // ),
    appBarTheme: const AppBarTheme(
      
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 20,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Color(0xFF242526),
          statusBarIconBrightness: Brightness.dark,
        ),
        titleTextStyle: TextStyle(
            color: Color(0xFFE4E6EB),
            fontSize: 24,
            fontFamily:  "almawadah" ,
            fontWeight: FontWeight.bold),
        iconTheme: IconThemeData(
          color: Color(0xFFE4E6EB),
        )),
    iconButtonTheme: const IconButtonThemeData(
        style: ButtonStyle(
            iconSize: WidgetStatePropertyAll(24),
            iconColor: WidgetStatePropertyAll(Colors.white))),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
      bodyLarge: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 255, 255, 255)),
      bodySmall: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      labelSmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey[300]),
      labelLarge: const TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      labelMedium: const TextStyle(
          fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: const TextStyle(
          fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      displayLarge: const TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      titleMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
    drawerTheme:
        const DrawerThemeData(backgroundColor: QuranDarkSecondaryColor,elevation: 16,));
