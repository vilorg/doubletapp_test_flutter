import 'package:doubletapp_habits/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final ThemeData themeApp = ThemeData(
  useMaterial3: true,
  primarySwatch: getMaterialColor(whiteColor),
  dividerColor: blackColor,
  disabledColor: lightOrangeColor,
  focusColor: darkOrangeColor,
  primaryColorLight: darkOrangeColor,
  primaryColor: darkOrangeColor,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      foregroundColor: MaterialStateProperty.all(whiteColor),
      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return darkOrangeColor;
          } else if (states.contains(MaterialState.disabled)) {
            return lightOrangeColor;
          }
          return darkOrangeColor;
        },
      ),
      padding: MaterialStateProperty.all(const EdgeInsets.all(8)),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
      elevation: MaterialStateProperty.all(0),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      padding: MaterialStateProperty.all<EdgeInsets>(defaultPadding),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(borderRadius: defaultBorderRadius),
      ),
    ),
  ),
  textSelectionTheme: const TextSelectionThemeData(cursorColor: blackColor),
  fontFamily: 'Nunito',
  scaffoldBackgroundColor: backgroundColor,
  // canvasColor: lightOrangeColor,
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: greyColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
    fillColor: whiteColor,
    filled: true,
    border: OutlineInputBorder(
        borderRadius: defaultBorderRadius, borderSide: const BorderSide()),
    errorBorder: OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: const BorderSide(color: redColor),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: const BorderSide(color: redColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: defaultBorderRadius,
      borderSide: const BorderSide(color: lightOrangeColor),
    ),
    errorStyle: const TextStyle(
      color: redColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    color: Colors.transparent,
    titleTextStyle: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 16,
    ),
  ),
  radioTheme: RadioThemeData(
    fillColor: MaterialStateProperty.all<Color>(darkOrangeColor),
  ),
  // bottomNavigationBarTheme: BottomNavigationBarThemeData(
  //   type: BottomNavigationBarType.fixed,
  //   backgroundColor: lightBlueColor,
  //   selectedItemColor: whiteColor,
  //   unselectedItemColor: blackColor,
  //   selectedLabelStyle: const TextStyle(
  //     color: whiteColor,
  //     fontWeight: FontWeight.w500,
  //     fontFamily: 'Inter',
  //     fontSize: 12,
  //   ),
  // unselectedLabelStyle: const TextStyle(
  //   color: blackColor,
  //   fontWeight: FontWeight.w500,
  //   fontFamily: 'Inter',
  //   fontSize: 12,
  // ),
  // ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 36,
    ),
    titleMedium: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 21,
    ),
    titleSmall: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 16,
    ),
    bodyLarge: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
    bodyMedium: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w700,
      fontFamily: 'Nunito',
      fontSize: 12,
    ),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: greenColor,
    foregroundColor: whiteColor,
    iconSize: 40,
    elevation: 0,
    focusElevation: 0,
    hoverElevation: 0,
    disabledElevation: 0,
    highlightElevation: 0,
    // shape: BeveledRectangleBorder(),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: darkOrangeColor,
    indicatorColor: darkOrangeColor,
    labelStyle: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
    unselectedLabelStyle: TextStyle(
      color: textColor,
      fontWeight: FontWeight.w400,
      fontFamily: 'Nunito',
      fontSize: 14,
    ),
  ),
);
