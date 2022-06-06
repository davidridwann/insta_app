import 'package:flutter/widgets.dart';

extension ResponsiveInt on int {
  dynamic w(BuildContext context) => Responsive(context).w(this.toDouble());
  dynamic h(BuildContext context) => Responsive(context).h(this.toDouble());
  dynamic f(BuildContext context) => Responsive(context).f(this.toDouble());
  dynamic wp(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 100.0);
  dynamic hp(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 100.0);
}

extension ResponsiveDouble on double {
  dynamic w(BuildContext context) => Responsive(context).w(this.toDouble());
  dynamic h(BuildContext context) => Responsive(context).h(this.toDouble());
  dynamic f(BuildContext context) => Responsive(context).f(this.toDouble());
  dynamic wp(BuildContext context) =>
      MediaQuery.of(context).size.width * (this / 100.0);
  dynamic hp(BuildContext context) =>
      MediaQuery.of(context).size.height * (this / 100.0);
}

class Responsive {
  double _originScreenWidth = 411.42857142857144;
  double _originScreenHeight = 569.1428571428571;
  double? _screenWidth;
  double? _screenHeight;
  double? _blockSize;
  double? _blockSizeVertical;
  double? _textScaleFactor;
  BuildContext context;

  Responsive(this.context) {
    if (MediaQuery.of(context).size.height /
            MediaQuery.of(context).size.width >=
        1.77777778) {
      _originScreenWidth = 360.0;
      _originScreenHeight = 640.0;
    }
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
    _blockSize = _screenWidth! / 100;
    _blockSizeVertical = _screenHeight! / 100;
    _textScaleFactor = _screenWidth! / _originScreenWidth;
  }

  double h(double height) {
    var calculation = (height / _originScreenHeight) * 100;
    return calculation * _blockSizeVertical!;
  }

  double w(double width) {
    var calculation = (width / _originScreenWidth) * 100;
    return calculation * _blockSize!;
  }

  double f(double size) {
    return size * _textScaleFactor!;
  }
}
