import 'package:flutter/material.dart';

const Color whiteColor = Colors.white;

const Color darkOrangeColor = Color.fromRGBO(255, 92, 0, 1);
const Color lightOrangeColor = Color.fromRGBO(255, 164, 80, 1);
const Color redColor = Colors.red;
const Color greyColor = Color.fromRGBO(102, 102, 102, 1);
const Color blackColor = Colors.black;
const Color textColor = Color.fromRGBO(47, 47, 47, 1);
const Color greenColor = Color.fromRGBO(55, 200, 113, 1);
const Color backgroundColor = Color.fromRGBO(252, 252, 255, 1);

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;
  final int alpha = color.alpha;

  final Map<int, Color> shades = {
    50: Color.fromARGB(alpha, red, green, blue),
    100: Color.fromARGB(alpha, red, green, blue),
    200: Color.fromARGB(alpha, red, green, blue),
    300: Color.fromARGB(alpha, red, green, blue),
    400: Color.fromARGB(alpha, red, green, blue),
    500: Color.fromARGB(alpha, red, green, blue),
    600: Color.fromARGB(alpha, red, green, blue),
    700: Color.fromARGB(alpha, red, green, blue),
    800: Color.fromARGB(alpha, red, green, blue),
    900: Color.fromARGB(alpha, red, green, blue),
  };

  return MaterialColor(color.value, shades);
}

const double defaultPaddingInt = 15.0;
const double smalSpacerInt = 8.0;
const EdgeInsets defaultPadding = EdgeInsets.all(defaultPaddingInt);

const double defaultBorderRadiusInt = 7.0;
BorderRadius defaultBorderRadius =
    BorderRadius.circular(defaultBorderRadiusInt);

const SizedBox defaultSpacer = SizedBox(
  width: defaultPaddingInt,
  height: defaultPaddingInt,
);

const SizedBox defaultSmalSpacer = SizedBox(
  width: smalSpacerInt,
  height: smalSpacerInt,
);

DateTime initDateTime = DateTime(2020);

const List<BoxShadow> shadow = [
  BoxShadow(
    offset: Offset(1, 1),
    color: Color.fromRGBO(200, 200, 200, 0.15),
    blurRadius: 14,
    spreadRadius: 6,
  )
];

const String habbitsBoxName = "habbits";

const String token = "3b5761b6-0476-45c4-a2ee-481278391542";

// String typeToString(TypeHabbit typeHabbit) {
//   switch (typeHabbit) {
//     case TypeHabbit.good:
//       return "Полезная привычка";
//     default:
//   }
// }
