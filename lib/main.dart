import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';
import 'app/theme/colors.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.dark, statusBarColor: primaryColor));

  // kunci orientasi device menjadi portrait
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  ).then((_) {
    Future.delayed(
      const Duration(milliseconds: 640),
      () => runApp(
        const KlasterifyApp(),
      ),
    );
  });
}

class KlasterifyApp extends StatelessWidget {
  const KlasterifyApp({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final bool isIntroductionRead = storage.read('isIntroductionRead') ?? false;
    return GetMaterialApp(
      title: "Klasterify",
      initialRoute: isIntroductionRead ? Routes.HOME : Routes.INTRODUCTION,
      getPages: AppPages.routes,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        visualDensity: VisualDensity.comfortable,

        // default color theme
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: whiteColor,
        ),
        primaryColor: primaryColor,
        indicatorColor: primaryColor,
        hintColor: greyColor,
        cardColor: whiteColor,
        unselectedWidgetColor: greyColor,

        // default input decoration for textfield
        inputDecorationTheme: const InputDecorationTheme(
            // focusColor: primaryColor,
            // iconColor: secondaryColor,

            // focusedBorder: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: accentColor,
            //     width: 1.5,
            //   ),
            // ),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(
            //     color: silverColor,
            //     width: 2.5,
            //   ),
            // ),
            // activeIndicatorBorder: BorderSide(color: primaryColor),
            // outlineBorder: BorderSide(color: silverColor),
            ),
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          background: backgroundColor,
          error: errorColor,
        ),
      ),
    );
  }
}
