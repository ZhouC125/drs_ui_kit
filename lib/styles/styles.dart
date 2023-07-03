// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import 'dart:ui';
import 'package:drs_ui_kit/drs_ui_kit.dart';
import 'package:flutter/material.dart';
import 'theme/theme.dart';
/// 占位符
const String placeholder = '-';

@immutable
class AppStyle {
  AppStyle({Size designSize = const Size(750, 1334)}) {
    /// 屏幕的逻辑宽度=屏幕物理宽度/屏幕的像素倍数
    var screenWidth = PlatformDispatcher.instance.views.first.physicalSize/PlatformDispatcher.instance.views.first.devicePixelRatio;
    final screenSize = screenWidth ?? designSize;
    final scaleWidth = screenSize.width / designSize.width;
    final scaleHeight = screenSize.height / designSize.height;
    scale = min(scaleWidth, scaleHeight);
  }
  /// 屏幕缩放因子
  late final double scale;

  /// 公共TextStyle配置
  late final _Text text = _Text(scale);

  /// Padding and margin values
  late final _Insets insets = _Insets(scale);

  ///公共阴影配置
  late final _Shadows shadows = _Shadows();

  ///公共圆角配置
  late final _BorderRadius borderRadius = _BorderRadius();

  /// 公共主题配置
  late final ThemeData themeData = ThemeInfo().themeData;

  late final double lineHeight = UniversalPlatform.isAndroid ? 1.25 : 1.3;

  Widget lineWidget({Color? color, double? height}) {
    return Container(
      height: height ?? 1,
      color: color ?? lineColor,
    );
  }
}

@immutable
class _Text {
  _Text(this._scale);
  final double _scale;
  late final TextStyle maxTitle = _createFont(
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      sizePx: 50 * _scale,
      heightPx: 72);

  late final TextStyle displayMedium = _createFont(
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
      sizePx: 48* _scale,
      heightPx: 66);

  late final TextStyle headline = _createFont(
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 40 * _scale,
      heightPx: 56);

  late final TextStyle title = _createFont(
      const TextStyle(
        color: black33Color,
        fontWeight: FontWeight.bold,
      ),
      sizePx: 36 * _scale,
      heightPx: 50);

  late final TextStyle headlineLarge = _createFont(
      TextStyle(
        color: FF999999Color.withOpacity(0.97),
        fontWeight: FontWeight.w400,
      ),
      sizePx: 32 * _scale,
      heightPx: 44);

  late final TextStyle headlineSmall = _createFont(
      const TextStyle(
        color: black33Color,
        fontWeight: FontWeight.w500,
      ),
      sizePx: 30 * _scale,
      heightPx: 42);

  late final TextStyle smallTitle = _createFont(
      const TextStyle(
        color: iconColor,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 28 * _scale,
      heightPx: 40);

  late final TextStyle mediumTitle = _createFont(
      const TextStyle(
        color: bgBlackColor,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 26 * _scale,
      heightPx: 36);

  late final TextStyle subTitle = _createFont(
      const TextStyle(
        color: iconColor,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 24 * _scale,
      heightPx: 34);

  late final TextStyle sub32Title = _createFont(
      const TextStyle(
        color: iconColor,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 24 * _scale,
      heightPx: 32);

  late final TextStyle titleMedium = _createFont(
      const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
      sizePx: 22 * _scale,
      heightPx: 30);

  TextStyle _createFont(TextStyle style,
      {required double sizePx,
      double? heightPx,
      double? spacingPc,
      FontWeight? weight}) {
    if (heightPx != null) {
      heightPx *= _scale;
    }
    return style.copyWith(
        fontSize: sizePx,
        height: heightPx != null ? (heightPx / sizePx) : style.height,
        letterSpacing:
            spacingPc != null ? sizePx * spacingPc * 0.01 : style.letterSpacing,
        fontWeight: weight);
  }
}

@immutable
class _Shadows {
  final bottomBarSoft = [
    const BoxShadow(
        color: Color(0xFFE7F2FF), offset: Offset(0, -1), blurRadius: 4.0),
  ];

  final card = [
    BoxShadow(
        color: bgBlackColor.withOpacity(0.05),
        offset: const Offset(0, 0),
        blurRadius: 5.0),
  ];
}

@immutable
class _BorderRadius {
  final cRoundRadius = const BorderRadius.all(
    Radius.circular(999),
  );

  final all16 = const BorderRadius.all(
    Radius.circular(16),
  );

  final all8 = const BorderRadius.all(
    Radius.circular(8),
  );

  final all4 = const BorderRadius.all(
    Radius.circular(4),
  );

  final all2 = const BorderRadius.all(
    Radius.circular(2),
  );
  final topRadius20 = const BorderRadius.only(
    topLeft: Radius.circular(20),
    topRight: Radius.circular(20),
  );

  final diagonalTop8 = const BorderRadius.only(
    topRight: Radius.circular(8),
    bottomLeft: Radius.circular(8),
  );

  final diagonalBottom8 = const BorderRadius.only(
    bottomRight: Radius.circular(8),
    topLeft: Radius.circular(8),
  );
}

@immutable
class _Insets {
  _Insets(this._scale);
  final double _scale;

  late final double i6 = 6 * _scale;
  late final double i8 = 8 * _scale;
  late final double i10 = 10 * _scale;
  late final double i12 = 12 * _scale;
  late final double i14 = 14 * _scale;
  late final double i16 = 16 * _scale;
  late final double i20 = 20 * _scale;
  late final double i24 = 24 * _scale;
  late final double i32 = 32 * _scale;
  late final double i48 = 48 * _scale;
  late final double i64 = 64 * _scale;
  late final double i96 = 96 * _scale;
}
