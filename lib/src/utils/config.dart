import 'package:flutter_resume_template/flutter_resume_template.dart';

class Config {
  static dynamicHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  static dynamicWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static Padding padding = Padding(padding: EdgeInsets.all(tenPx));

  static EdgeInsetsGeometry margin = EdgeInsets.all(tenPx);

  static double smallHeight = 250.0;
  static double mediumHeight = 500.0;
  static double largeHeight = 800.0;

  static double smallWidth = 150.0;
  static double mediumWidth = 250.0;
  static double largeWidth = 400.0;

  static double tenPx = 10.0;
  static double heightPx = 8.0;
  static double sixPx = 6.0;
  static double fourPx = 4.0;
  static double threePx = 3.0;
  static double twoPx = 2.0;
  static double onePx = 1.0;
  static double oneHalfPx = 0.5;
  static double oPx = 0.0;

  static Decoration shakingBox() => BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(width: 0.2, color: Colors.grey.shade400),
      );
  static Decoration decoration(BuildContext context) => BoxDecoration(
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(twoPx / 10),
          spreadRadius: sixPx,
          blurRadius: heightPx,
          offset: Offset(oPx, fourPx), // changes position of shadow
        ),
      ],
      borderRadius: BorderRadius.all(Radius.circular(heightPx)),
      border: Border.all(style: BorderStyle.none));
}