import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minimal_adhan/extensions.dart';
import 'package:minimal_adhan/localization/supportedLangs.dart';
import 'package:minimal_adhan/prviders/dependencies/GlobalDependencyProvider.dart';



LinearGradient getOnBackgroundGradient(BuildContext context, {double opacity = 1}) {
  return context.theme.brightness == Brightness.dark
      ?  LinearGradient(colors: [
    const Color.fromRGBO(81, 9, 177, 1.0).withOpacity(opacity),
    const Color.fromRGBO(169, 108, 238, 1.0).withOpacity(opacity)
  ],)
      :  LinearGradient(colors: [
    const Color(0xFF134E5E).withOpacity(opacity),
    const Color(0xFF71B280).withOpacity(opacity),
  ],);
}

Color getDrawerShadowColor(BuildContext context) {
  return context.theme.brightness == Brightness.light
      ? Colors.teal
      : const Color.fromRGBO(90, 15, 186, 1.0);
}

ThemeData getLightTheme(
        BuildContext context, GlobalDependencyProvider globalDependency) =>
    ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            iconTheme: context.theme.iconTheme.copyWith(color: Colors.black),
            systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),),
        cardColor: Colors.white,
        brightness: Brightness.light,
        fontFamily: getFont(globalDependency.locale),
        textTheme: getTextTheme(context, globalDependency.locale),
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.blueGrey,
        ),);

ThemeData getDarkTheme(
    BuildContext context, GlobalDependencyProvider globalDependency,) {
  const darkBack = Colors.black;

  return ThemeData(
      bottomSheetTheme:
          context.theme.bottomSheetTheme.copyWith(backgroundColor: darkBack),
      appBarTheme: AppBarTheme(
        foregroundColor: Colors.white,
        backgroundColor: darkBack,
        systemOverlayStyle: SystemUiOverlayStyle.light
            .copyWith(statusBarColor: Colors.transparent),
      ),
      fontFamily: getFont(globalDependency.locale),
      textTheme: getTextTheme(context, globalDependency.locale).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white70,
      ),
      canvasColor: darkBack,
      cardColor: darkBack,
      dialogBackgroundColor: darkBack,
      scaffoldBackgroundColor: darkBack,
      backgroundColor: darkBack,
      snackBarTheme: context.theme.snackBarTheme
          .copyWith(backgroundColor: Colors.white.withOpacity(0.8)),
      colorScheme: const ColorScheme.dark(
        secondary: Colors.white,
      ),);
}
