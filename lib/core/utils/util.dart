import 'dart:ui' as ui;

import 'package:flutter/material.dart';

double get pixelRatio => ui.window.devicePixelRatio;
ui.Size get size => ui.window.physicalSize / pixelRatio;

double get width => size.width;
double get height => size.height;

double get kVerticalMargin => height * 0.01;
double get kHorizontalMargin => width * 0.02;
String googlekey = "AIzaSyCy5SdslwZETLYR_UlDjEqQT0qCdGaOasQ";

double get kBorderRadius => 16;
// screen height
double getHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

// screen width
double getWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getResponsiveFont(double fontSize) {
  double widthInDp = width;
  double physicalPixelWidth = width * pixelRatio;
  double dpi = ((physicalPixelWidth / widthInDp) * 160) - 5;

  if (dpi <= 120) {
    return 0.25 * fontSize;
  } else if (dpi <= 160) {
    return (1 / 3) * fontSize;
  } else if (dpi <= 240) {
    return 0.5 * fontSize;
  } else if (dpi <= 320) {
    return 0.75 * fontSize;
  } else if (dpi <= 480) {
    return 1.0 * fontSize;
  } else if (dpi <= 640) {
    return (4 / 3) * fontSize;
  } else {
    return 1.8 * fontSize;
  }
}

// get height



