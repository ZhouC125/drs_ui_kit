import 'dart:math';
import 'dart:ui' as ui show TextHeightBehavior;

import 'package:drs_ui_kit/utils/platform/universal_platform.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DrsText extends StatelessWidget {
  const DrsText(
    this.data, {
    this.font,
    this.fontWeight,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.isTextThrough = false,
    this.lineThroughColor = Colors.white,
    this.package,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.forceVerticalCenter = false,
    Key? key,
  })  : textSpan = null,
        super(key: key);

  /// 富文本构造方法
  const DrsText.rich(
    this.textSpan, {
    this.font,
    this.fontWeight,
    this.textColor = Colors.black,
    this.backgroundColor,
    this.isTextThrough = false,
    this.lineThroughColor = Colors.white,
    this.package = 'tdesign_flutter',
    Key? key,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.forceVerticalCenter = false,
  })  : data = null,
        super(key: key);

  /// 字体尺寸，包含大小size和行高height
  final Font? font;

  /// 字体粗细
  final FontWeight? fontWeight;

  /// 文本颜色
  final Color textColor;

  /// 背景颜色
  final Color? backgroundColor;

  /// 字体包名
  final String? package;

  /// 是否是横线穿过样式(删除线)
  final bool? isTextThrough;

  /// 删除线颜色，对应TestStyle的decorationColor
  final Color? lineThroughColor;

  /// 自定义的TextStyle，其中指定的属性，将覆盖扩展的外层属性
  final TextStyle? style;

  /// The text to display.
  ///
  /// This will be null if a [textSpan] is provided instead.
  final String? data;

  /// The text to display as a [InlineSpan].
  ///
  /// This will be null if [data] is provided instead.
  final InlineSpan? textSpan;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// How the text should be aligned horizontally.
  final TextAlign? textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [data] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any.
  final TextDirection? textDirection;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool? softWrap;

  /// How visual overflow should be handled.
  ///
  /// If this is null [TextStyle.overflow] will be used, otherwise the value
  /// from the nearest [DefaultTextStyle] ancestor will be used.
  final TextOverflow? overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  ///
  /// The value given to the constructor as textScaleFactor. If null, will
  /// use the [MediaQueryData.textScaleFactor] obtained from the ambient
  /// [MediaQuery], or 1.0 if there is no [MediaQuery] in scope.
  final double? textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  ///
  /// If this is null, but there is an ambient [DefaultTextStyle] that specifies
  /// an explicit number for its [DefaultTextStyle.maxLines], then the
  /// [DefaultTextStyle] value will take precedence. You can use a [RichText]
  /// widget directly to entirely override the [DefaultTextStyle].
  final int? maxLines;

  /// {@template flutter.widgets.Text.semanticsLabel}
  /// An alternative semantics label for this text.
  ///
  /// If present, the semantics of this widget will contain this value instead
  /// of the actual text. This will overwrite any of the semantics labels applied
  /// directly to the [TextSpan]s.
  ///
  /// This is useful for replacing abbreviations or shorthands with the full
  /// text value:
  ///
  /// ```dart
  /// const Text(r'$$', semanticsLabel: 'Double dollars')
  /// ```
  /// {@endtemplate}
  final String? semanticsLabel;

  /// {@macro flutter.painting.textPainter.textWidthBasis}
  final TextWidthBasis? textWidthBasis;

  /// {@macro dart.ui.textHeightBehavior}
  final ui.TextHeightBehavior? textHeightBehavior;


  final bool forceVerticalCenter;

  @override
  Widget build(BuildContext context) {
    if (forceVerticalCenter) {
      var config = getConfiguration(context);
      var paddingConfig = config?.paddingConfig;
      //
      var textFont = font ??
          Font(size: 16, lineHeight: 24);
      var fontSize = style?.fontSize ?? textFont.size;
      var height = style?.height ?? textFont.height;

      paddingConfig ??= TDTextPaddingConfig.getDefaultConfig();
      var showHeight = min(paddingConfig.heightRate, height);
      return Container(
        color: style?.backgroundColor ?? backgroundColor,
        height: fontSize * height,
        padding: paddingConfig.getPadding(fontSize, height),
        child: _getRawText(
            context: context,
            textStyle: getTextStyle(context, height: showHeight)),
      );
    }
    return Container(
      color: style?.backgroundColor ?? backgroundColor,
      child: _getRawText(context: context),
    );
  }

  /// 提取成方法，允许业务定义自己的TDTextConfiguration
  TDTextConfiguration? getConfiguration(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TDTextConfiguration>();
  }

  TextStyle? getTextStyle(BuildContext? context,
      {double? height, Color? backgroundColor}) {
    var textFont = font ??
        Font(size: 16, lineHeight: 24);
    return TextStyle(
      inherit: style?.inherit ?? true,
      color: style?.color ?? textColor,

      /// 不使用系统本身的背景色，因为系统属性存在中英文是，会导致颜色出现阶梯状
      backgroundColor: backgroundColor,
      fontSize: style?.fontSize ?? textFont.size,
      fontWeight: style?.fontWeight ?? fontWeight ?? textFont.fontWeight,
      fontStyle: style?.fontStyle,
      letterSpacing: style?.letterSpacing,
      wordSpacing: style?.wordSpacing,
      textBaseline: style?.textBaseline,
      height: height ?? style?.height ?? textFont.height,
      leadingDistribution: style?.leadingDistribution,
      locale: style?.locale,
      foreground: style?.foreground,
      background: style?.background,
      shadows: style?.shadows,
      fontFeatures: style?.fontFeatures,
      decoration: style?.decoration ??
          (isTextThrough! ? TextDecoration.lineThrough : TextDecoration.none),
      decorationColor: style?.decorationColor ?? lineThroughColor,
      decorationStyle: style?.decorationStyle,
      decorationThickness: style?.decorationThickness,
      debugLabel: style?.debugLabel,
      fontFamily: style?.fontFamily ,
      fontFamilyFallback: style?.fontFamilyFallback,
      package: package,
    );
  }

  /// 获取系统原始Text，以便使用到只能接收系统Text组件的地方
  /// 转化为系统原始Text后，将失去padding和background属性
  Text getRawText({BuildContext? context}) {
    return _getRawText(context: context, backgroundColor: backgroundColor);
  }

  Text _getRawText(
      {BuildContext? context, TextStyle? textStyle, Color? backgroundColor}) {
    return textSpan == null
        ? Text(
            data!,
            key: key,
            style: textStyle ??
                getTextStyle(context, backgroundColor: backgroundColor),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
          )
        : Text.rich(
            textSpan!,
            style: textStyle ??
                getTextStyle(context, backgroundColor: backgroundColor),
            strutStyle: strutStyle,
            textAlign: textAlign,
            textDirection: textDirection,
            locale: locale,
            softWrap: softWrap,
            overflow: overflow,
            textScaleFactor: textScaleFactor,
            maxLines: maxLines,
            semanticsLabel: semanticsLabel,
            textWidthBasis: textWidthBasis,
            textHeightBehavior: textHeightBehavior,
          );
  }
}

/// TextSpan的TDesign扩展，将部分TextStyle中的参数扁平化。
class TDTextSpan extends TextSpan {
  /// 构造参数，扩展参数释义可参考[DrsText]中字段注释
  TDTextSpan({
    BuildContext?
        context, // 如果未设置font，且不想使用默认的fontBodyLarge尺寸时，需设置context，否则可省略
    Font? font,
    FontWeight? fontWeight,
    String? fontFamily,
    Color textColor = Colors.black,
    bool? isTextThrough = false,
    Color? lineThroughColor = Colors.white,
    String package = 'tdesign_flutter',
    String? text,
    List<InlineSpan>? children,
    TextStyle? style,
    GestureRecognizer? recognizer,
    MouseCursor? mouseCursor,
    PointerEnterEventListener? onEnter,
    PointerExitEventListener? onExit,
    String? semanticsLabel,
  }) : super(
          text: text,
          children: children,
          style: _getTextStyle(context, style, font, fontWeight, fontFamily,
              textColor, isTextThrough, lineThroughColor, package),
          recognizer: recognizer,
          mouseCursor: mouseCursor,
          onEnter: onEnter,
          onExit: onExit,
          semanticsLabel: semanticsLabel,
        );

  static TextStyle? _getTextStyle(
    BuildContext? context,
    TextStyle? style,
    Font? font,
    FontWeight? fontWeight,
    String? fontFamily,
    Color textColor,
    bool? isTextThrough,
    Color? lineThroughColor,
    String package,
  ) {
    var textFont = font ??
        Font(size: 16, lineHeight: 24);
    return TextStyle(
      inherit: style?.inherit ?? true,
      color: style?.color ?? textColor,
      backgroundColor: style?.backgroundColor,
      fontSize: style?.fontSize ?? textFont.size,
      fontWeight: style?.fontWeight ?? fontWeight ?? textFont.fontWeight,
      fontStyle: style?.fontStyle,
      letterSpacing: style?.letterSpacing,
      wordSpacing: style?.wordSpacing,
      textBaseline: style?.textBaseline,
      height: style?.height ?? textFont.height,
      leadingDistribution: style?.leadingDistribution,
      locale: style?.locale,
      foreground: style?.foreground,
      background: style?.background,
      shadows: style?.shadows,
      fontFeatures: style?.fontFeatures,
      decoration: style?.decoration ??
          (isTextThrough! ? TextDecoration.lineThrough : TextDecoration.none),
      decorationColor: style?.decorationColor ?? lineThroughColor,
      decorationStyle: style?.decorationStyle,
      decorationThickness: style?.decorationThickness,
      debugLabel: style?.debugLabel,
      fontFamily: style?.fontFamily ?? fontFamily,
      fontFamilyFallback: style?.fontFamilyFallback,
      package: package,
    );
  }
}

/// 存储可以自定义TDText居中算法数据的内部控件
class TDTextConfiguration extends InheritedWidget {

  /// forceVerticalCenter=true时，内置padding配置
  final TDTextPaddingConfig? paddingConfig;

  const TDTextConfiguration(
      {this.paddingConfig, Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant TDTextConfiguration oldWidget) {
    return paddingConfig != oldWidget.paddingConfig;
  }
}

/// 通过Padding自定义TDText居中算法
class TDTextPaddingConfig {
  static TDTextPaddingConfig? _defaultConfig;

  /// 获取默认配置
  static TDTextPaddingConfig getDefaultConfig() {
    _defaultConfig ??= TDTextPaddingConfig();
    return _defaultConfig!;
  }

  /// 获取padding
  EdgeInsetsGeometry getPadding(double fontSize, double height) {
    var paddingFont = fontSize * paddingRate;
    num paddingLeading;
    if (height < heightRate) {
      paddingLeading = 0;
    } else {
      if (UniversalPlatform.isIOS || UniversalPlatform.isAndroid) {
        paddingLeading = (height * 0.5 - paddingExtraRate) * fontSize;
      } else {
        paddingLeading = 0;
      }
    }
    var paddingTop = paddingFont + paddingLeading;
    if (paddingTop < 0) {
      paddingTop = 0;
    }
    return EdgeInsets.only(top: paddingTop);
  }

  /// 以多个汉字测量计算的平均值,Android为Pixel 4模拟器，iOS为iphone 8 plus 模拟器
  double get paddingRate => UniversalPlatform.isWeb
      ? 3 / 8
      : UniversalPlatform.isAndroid
          ? -7 / 128
          : 0;

  /// 以多个汉字测量计算的平均值,Android为Pixel 4模拟器，iOS为iphone 8 plus 模拟器
  double get paddingExtraRate => UniversalPlatform.isAndroid ? 115 / 256 : 97 / 240;

  /// height比率，因为设置1时，Android文字可能显示不全，默认为1.1
  double get heightRate => UniversalPlatform.isAndroid ? 1.1 : 1;
}

class Font {
  late double size;
  late double height;
  late FontWeight fontWeight;

  Font({required int size, required int lineHeight, this.fontWeight = FontWeight.w400}) {
    this.size = size.toDouble();
    height = lineHeight.toDouble() / size;
  }

  factory Font.fromJson(Map<String, dynamic> map) =>
      Font(size: map['size'], lineHeight: map['lineHeight'], fontWeight: _getFontWeight(map));

  static _getFontWeight(Map<String, dynamic> map) {
    int weight = map['fontWeight'] ?? 4;
    return FontWeight.values[weight - 1];
  }
}
