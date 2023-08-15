import 'dart:ui';

import 'package:flutter/material.dart';

/// @description : 通用的context扩展
/// @class : context_extensions
/// @date :  2023/5/11 18:12
/// @name : achen
extension SizedContext on BuildContext {

  ///  View.of(this)
  FlutterView get fv => View.of(this);

  /// 是否是横屏
  bool get isLandscape => MediaQuery.orientationOf(this) == Orientation.landscape;

  /// MediaQuery.of(context).size
  Size get sizePx => MediaQuery.sizeOf(this);

  /// MediaQuery.of(context).size.width
  double get widthPx => sizePx.width;

  /// MediaQuery.of(context).height
  double get heightPx => sizePx.height;

  /// MediaQuery.of(context).padding
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// MediaQuery.of(context).padding.left
  double get paddingBottom => padding.bottom;

  /// View.of(this).viewInsets
  ViewPadding get viewInsets => fv.viewInsets;

  /// View.of(this).physicalSize
  Size get physicalSize => fv.physicalSize;

  /// View.of(this).devicePixelRatio
  double get devicePixelRatio => fv.devicePixelRatio;
}
