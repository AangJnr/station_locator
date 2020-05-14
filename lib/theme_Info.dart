import 'package:flutter/material.dart';

const colorPrimary = Colors.greenAccent;

//dark colors
const canvasColorDark = Color.fromRGBO(27, 30, 37, 1);
const textColorDark = Colors.white;
const cardColorDark = Color.fromRGBO(33, 35, 42, 1);

const spacingNormal = 16.0;
const spacingHalf = 8.0;
const spacingQuarter = 4.0;

const paddingNormal = 16.0;
const paddingHalf = 8.0;
const paddingQuarter = 4.0;

const appBarMaginTop = 40;

final darkTheme = ThemeData(
  scaffoldBackgroundColor: canvasColorDark,
  accentColor: colorPrimary,
  canvasColor: canvasColorDark,
  fontFamily: 'Roboto',
  textTheme: ThemeData.dark().textTheme.copyWith(
        headline6: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: textColorDark,
            letterSpacing: 5),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColorDark,
        ),
        subtitle2: TextStyle(
          color: textColorDark,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
  colorScheme: ColorScheme.dark(
    primary: canvasColorDark,
    onPrimary: canvasColorDark,
    primaryVariant: canvasColorDark,
    secondary: colorPrimary,
  ),
  cardTheme: CardTheme(
    color: cardColorDark,
  ),
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),
);

final lightTheme = ThemeData.light();
