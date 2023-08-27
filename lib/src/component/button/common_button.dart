import 'package:drs_ui_kit/drs_ui_kit.dart';
import 'package:flutter/material.dart';

/// 可以考虑合到原来的Button上
class CommonButton extends StatefulWidget {
  const CommonButton._({
    this.onPressed,
    this.text,
    this.child,
    this.boxDecoration,
    required this.margin,
    this.padding,
    this.textStyle,
    required this.enabled,
    required this.isBig,
    this.filled = true,
    this.isThemeColor = true,
    required this.minWidth,
    required this.maxWidth,
    this.color,
    this.textColor,
  });

  final VoidCallback? onPressed;
  final String? text;
  final Widget? child;
  final BoxDecoration? boxDecoration;
  final EdgeInsets margin;
  final EdgeInsets? padding;
  final TextStyle? textStyle;
  final bool enabled;
  final bool isBig;
  final Color? color;
  final Color? textColor;

  /// ---下面↓小按钮专用属性---
  final bool filled;
  final bool isThemeColor;
  final double minWidth;
  final double maxWidth;

  static CommonButton big({
    VoidCallback? onPressed,
    String? text,
    Widget? child,
    BoxDecoration? boxDecoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    bool? enabled,
    Color? color,
    Color? textColor,
  }) {
    return CommonButton._(
      isBig: true,
      onPressed: onPressed,
      text: text,
      boxDecoration: boxDecoration,
      margin: margin ?? EdgeInsets.zero,
      padding: padding,
      textStyle: textStyle,
      enabled: enabled ?? true,
      maxWidth: double.infinity,
      minWidth: 0,
      color: color,
      textColor: textColor,
      child: child,
    );
  }

  static CommonButton small({
    VoidCallback? onPressed,
    String? text,
    Widget? child,
    BoxDecoration? boxDecoration,
    EdgeInsets? margin,
    EdgeInsets? padding,
    TextStyle? textStyle,
    bool? enabled,
    bool filled = true,
    bool isBorderThemeColor = true,
    double? maxWidth,
    double? minWidth,
    Color? color,
    Color? textColor,
  }) {
    return CommonButton._(
      isBig: false,
      onPressed: onPressed,
      text: text,
      boxDecoration: boxDecoration,
      margin: margin ?? EdgeInsets.zero,
      padding: padding,
      textStyle: textStyle,
      enabled: enabled ?? true,
      filled: filled,
      isThemeColor: isBorderThemeColor,
      maxWidth: maxWidth ?? double.infinity,
      minWidth: minWidth ?? 88,
      color: color,
      textColor: textColor,
      child: child,
    );
  }

  @override
  State<CommonButton> createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> {
  bool isBeingPressed = false;

  bool get isBig => widget.isBig;

  EdgeInsets get padding {
    if (widget.padding != null) {
      return widget.padding!;
    }
    if (widget.isBig) {
      return const EdgeInsets.symmetric(vertical: 10);
    }
    return const EdgeInsets.symmetric(vertical: 7, horizontal: 16);
  }

  BorderRadius get borderRadius => BorderRadius.circular(isBig ? 999 : 4);

  BoxDecoration get bgDecoration {
    if (widget.boxDecoration != null) {
      return widget.boxDecoration!;
    }
    if (isBig || widget.filled) {
      return BoxDecoration(
          color: widget.color ?? themeColor,
          borderRadius: borderRadius,
          border: Border.all(color: widget.color ?? themeColor));
    }
    return BoxDecoration(
      borderRadius: borderRadius,
      border: Border.all(color: widget.isThemeColor ? themeColor : iconColor),
    );
  }

  void _onTapDown(TapDownDetails event) {
    setState(() {
      isBeingPressed = true;
    });
  }

  void _onTapUp(TapUpDetails event) {
    setState(() {
      isBeingPressed = false;
    });
  }

  void _onTapCancel() {
    setState(() {
      isBeingPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color? maskColor;
    if (isBeingPressed) {
      maskColor = Colors.black.withOpacity(0.15);
    }
    if (!widget.enabled) {
      maskColor = Colors.white.withOpacity(0.5);
    }
    Color textColor = widget.textColor ?? Colors.white;
    if (!isBig && !widget.filled) {
      textColor = widget.isThemeColor ? themeColor : bigTitleColor;
    }
    Widget child = Container(
      foregroundDecoration: BoxDecoration(
        color: maskColor,
        borderRadius: borderRadius,
      ),
      decoration: bgDecoration,
      padding: padding,
      alignment: Alignment.center,
      child: widget.child ??
          Text(
            widget.text ?? '',
            style: widget.textStyle ??
                TextStyle(
                  fontSize: isBig ? 16: 12,
                  color: textColor,
                  height: $styles.lineHeight,
                  fontWeight: isBig ? FontWeight.w600 : null,
                ),
          ),
    );
    // 小按钮的情况下，不随着上级组件拉伸，用自己的约束
    if (!isBig) {
      child = UnconstrainedBox(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: widget.maxWidth,
            minWidth: widget.minWidth,
          ),
          child: child,
        ),
      );
    }
    return Padding(
      padding: widget.margin,
      child: widget.enabled
          ? GestureDetector(
              excludeFromSemantics: true,
              onTapDown: _onTapDown,
              onTapUp: _onTapUp,
              onTapCancel: _onTapCancel,
              onTap: widget.onPressed,
              child: child,
            )
          : child,
    );
  }
}
