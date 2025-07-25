import 'dart:ui' as ui;

double get pixelRatio =>
    ui.PlatformDispatcher.instance.views.first.devicePixelRatio;
ui.Size get size =>
    ui.PlatformDispatcher.instance.views.first.physicalSize / pixelRatio;

double get width => size.width;
double get height => size.height;

double get kVerticalMargin => height * 0.02;
double get kHorizontalMargin => width * 0.03;
