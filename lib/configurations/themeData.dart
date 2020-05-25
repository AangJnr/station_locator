import 'package:flutter/material.dart';

var colorPrimary = Colors.cyan[300];

//dark colors
const canvasColor = Colors.white; //Todo check for dark or light theme here
const textColor = Colors.black;
const cardColor = Color.fromRGBO(33, 35, 28, 1);

const spacingNormal = 16.0;
const spacingHalf = 8.0;
const spacingQuarter = 4.0;

const paddingNormal = 16.0;
const paddingHalf = 8.0;
const paddingQuarter = 4.0;

const appBarMaginTop = 50.0;

const appName = 'Shabo';

const maxWidth = 250.0;

var colors = [Colors.blue.withOpacity(0.7), Colors.blue.withOpacity(0.5)];

var buttonGradient = LinearGradient(
    begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors);

var linearGradient = LinearGradient(
  colors:
      colors /* [
    Color(0x00d6e8ee).withOpacity(0.7),
    Color(0x0097cadb).withOpacity(0.7),
  ] */
  ,
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

LinearGradient buildGradient(
        AlignmentGeometry begin, AlignmentGeometry end, List<Color> colors) =>
    LinearGradient(begin: begin, end: end, colors: colors);

const me =
    'https://instagram.facc6-1.fna.fbcdn.net/v/t51.2885-19/s320x320/71274115_628787994313272_2899341196700680192_n.jpg?_nc_ht=instagram.facc6-1.fna.fbcdn.net&_nc_ohc=0bSxn4oAbA0AX-G2GM4&oh=93d0b9321adf178e60fab4e6dc2a5cfd&oe=5EEBAA82';

final lightTheme = ThemeData(
  accentColor: colorPrimary,
  primarySwatch: Colors.blue,
  fontFamily: 'Roboto',
  iconTheme: ThemeData.light().iconTheme.copyWith(
        size: 20.0,
      ),
  textTheme: ThemeData.light().textTheme.copyWith(
      headline6: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w900,
        color: Colors.black,
      ),
      subtitle1: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      subtitle2: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.black,
        letterSpacing: 1,
      ),
      button:
          ThemeData.light().textTheme.subtitle1.copyWith(color: Colors.white),
      caption: TextStyle(
        fontSize: 12,
        color: Colors.black45,
        fontWeight: FontWeight.bold,
      )),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: canvasColor,
  accentColor: colorPrimary,
  canvasColor: canvasColor,
  fontFamily: 'Roboto',
  textTheme: ThemeData.dark().textTheme.copyWith(
        headline6: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            color: textColor,
            letterSpacing: 5),
        subtitle1: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
        subtitle2: TextStyle(
          color: textColor,
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
      ),
  colorScheme: ColorScheme.dark(
    primary: canvasColor,
    onPrimary: canvasColor,
    primaryVariant: canvasColor,
    secondary: colorPrimary,
  ),
  cardTheme: CardTheme(
    color: cardColor,
  ),
  iconTheme: IconThemeData(
    color: Colors.white54,
  ),
);
