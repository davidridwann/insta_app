// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, unnecessary_const

import 'package:insta_app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  BuildContext context;
  static Color black = Color(0xff2A2A2A);
  static Color primary = Color(0xff3498db);
  static Color darkPrimary = Color(0xff131C3E);
  static Color secondary = Color(0xffEC4067);
  static Color darkSecondary = Color(0xffE31745);
  static Color primaryDisableButton = Color(0xffC2C2C2);
  static Color blue = Color(0xff4751D7);
  static Color reddish = Color(0xffFF576B);
  static Color cyan = Color(0xff00D4E0);
  static Color orange = Color(0xffFFFF904A);
  static Color purple = Color(0xff874EDC);
  static Color blueGrey = Color(0xffA9C8F2);
  static Color magenta = Color(0xffE92B96);
  static Color darkYellow = Color(0xffFC9E4F);
  static Color strokeYellow = Color(0xffFB831D);

  static Color red = Color(0xffEC4067);
  static Color yellow = Color(0xffFFD228);
  static Color grey = Color(0xff757575);
  static Color green = Color(0xff03CEA4);
  static Color greyBg = Color(0xffFDFDFD);
  static Color stroke = Color(0xffDEDEDE);
  static Color white = Color(0xffffffff);
  static Color transparent = Color(0x00ffffff);

  static MaterialColor primaryMaterialColor = MaterialColor(
    0xff3498db,
    const <int, Color>{
      50: const Color(0xff3498db),
      100: const Color(0xff3498db),
      200: const Color(0xff3498db),
      300: const Color(0xff3498db),
      400: const Color(0xff3498db),
      500: const Color(0xff3498db),
      600: const Color(0xff3498db),
      700: const Color(0xff3498db),
      800: const Color(0xff3498db),
      900: const Color(0xff3498db),
    },
  );

  TextStyle? whiteBold32;
  TextStyle? whiteBold28;
  TextStyle? whiteBold26;
  TextStyle? whiteBold22;
  TextStyle? whiteOpacity14;
  TextStyle? whiteOpacity12;
  TextStyle? white16;
  TextStyle? white14;
  TextStyle? white12;
  TextStyle? white10;
  TextStyle? whiteBold16;
  TextStyle? whiteBold14;
  TextStyle? whiteBold12;
  TextStyle? blackBold20;
  TextStyle? black16;
  TextStyle? blackOpacity12;
  TextStyle? black70Opacity12;
  TextStyle? blackBold16;
  TextStyle? blackBold18;
  TextStyle? orangeBold18;
  TextStyle? greenBold18;
  TextStyle? redBold18;
  TextStyle? secondary14;
  TextStyle? secondary18;
  TextStyle? secondaryBold18;
  TextStyle? secondaryBold14;
  TextStyle? blackBold12;
  TextStyle? blackBold14;
  TextStyle? grayLetterSpacing12;
  TextStyle? grayBoldLetterSpacing12;
  TextStyle? gray12;
  TextStyle? grayNoHeight12;
  TextStyle? gray14;
  TextStyle? black12;
  TextStyle? black14;
  TextStyle? blackOpacity14;
  TextStyle? loginTitle;
  TextStyle? appbarTitle;
  TextStyle? primaryBold22;
  TextStyle? primaryBold18;
  TextStyle? primaryBold14;
  TextStyle? primaryBold12;
  TextStyle? primary12;

  TextStyle textStyle({
    double size = 14,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) {
    return GoogleFonts.poppins(
      textStyle: TextStyle(
        height: height! / size,
        fontSize: Responsive(context).f(size),
        color: color ?? Themes.black,
        fontWeight: fontWeight,
      ),
    );
  }

  Themes(this.context, {bool withLineHeight = false}) {
    primary12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.primary,
      ),
    );

    primaryBold12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold22 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(22),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    primaryBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.primary,
        fontWeight: FontWeight.bold,
      ),
    );

    loginTitle = GoogleFonts.cookie(
      textStyle: TextStyle(
          fontSize: Responsive(context).f(50),
          fontWeight: FontWeight.bold,
          foreground: Paint()
            ..shader = LinearGradient(
              // ignore: prefer_const_literals_to_create_immutables
              colors: <Color>[
                Colors.pinkAccent,
                Colors.deepPurpleAccent,
                Colors.red
                //add more color here.
              ],
            ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))),
    );

    appbarTitle = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Responsive(context).f(26),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold20 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(20),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    black16 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(16),
        color: Themes.black,
      ),
    );

    secondary14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.secondary,
      ),
    );

    secondary18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.secondary,
      ),
    );

    secondaryBold14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.secondary,
        fontWeight: FontWeight.bold,
      ),
    );

    secondaryBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.secondary,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    orangeBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.orange,
        fontWeight: FontWeight.bold,
      ),
    );

    greenBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.green,
        fontWeight: FontWeight.bold,
      ),
    );

    redBold18 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(18),
        color: Themes.red,
        fontWeight: FontWeight.bold,
      ),
    );

    black70Opacity12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackOpacity12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.black.withOpacity(0.6),
      ),
    );

    blackBold16 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(16),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackOpacity14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.black.withOpacity(0.6),
      ),
    );

    blackBold12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    blackBold14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.black,
        fontWeight: FontWeight.bold,
      ),
    );

    grayLetterSpacing12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 12.f(context),
        color: Color(0xff757575),
        letterSpacing: 2.0,
      ),
    );

    grayBoldLetterSpacing12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: 12.f(context),
        color: Color(0xff757575),
        letterSpacing: 2.0,
        fontWeight: FontWeight.bold,
      ),
    );

    gray12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.grey,
      ),
    );

    grayNoHeight12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Responsive(context).f(12),
        color: Themes.grey,
      ),
    );

    black12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Themes.black,
      ),
    );

    white16 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(16),
        color: Colors.white,
      ),
    );

    white14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Colors.white,
      ),
    );

    white12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Colors.white,
      ),
    );

    white10 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.2 : null,
        fontSize: Responsive(context).f(10),
        color: Colors.white,
      ),
    );

    gray14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.grey,
      ),
    );

    black14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Themes.black,
      ),
    );

    whiteBold16 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(16),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteOpacity14 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(14),
        color: Colors.white,
      ),
    );

    whiteOpacity12 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(12),
        color: Colors.white,
      ),
    );

    whiteBold32 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Responsive(context).f(32),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold28 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Responsive(context).f(28),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold26 = GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: Responsive(context).f(26),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );

    whiteBold22 = GoogleFonts.poppins(
      textStyle: TextStyle(
        height: withLineHeight ? 1.5 : null,
        fontSize: Responsive(context).f(22),
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
