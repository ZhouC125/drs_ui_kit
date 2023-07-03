import 'dart:async';
import 'dart:math';
import 'package:drs_ui_kit/component/loading/drs_circle_indicator.dart';
import 'package:drs_ui_kit/component/progress/progress.dart';
import 'package:flutter/material.dart';
import '../../drs_ui_kit.dart';

/// @description : 通用Toast提示,用于轻量级反馈或提示，
/// @class : drs_toast
enum IconTextDirection {
  horizontal, //横向
  vertical //竖向
}

class DrsToast {
  /// 普通文本Toast
  static void showText(String? text,
      {required BuildContext context,
      Duration? duration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
      _DrsTextToast(
        text: text,
      ),
      alignment: alignment,
      context: context,
    );
  }

  /// 带图标的Toast
  static void showIconText(String? text,
      {IconData? icon,
      IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
      _DrsIconTextToast(
        text: text,
        iconData: icon,
        iconTextDirection: direction,
      ),
      alignment: alignment,
      context: context,
    );
  }

  /// 成功提示Toast
  static void showSuccess(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
      _DrsIconTextToast(
        text: text,
        iconData: Icons.check_circle,
        iconTextDirection: direction,
      ),
      alignment: alignment,
      context: context,
    );
  }

  /// 警告Toast
  static void showWarning(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
      _DrsIconTextToast(
        text: text,
        iconData: Icons.error_outlined,
        iconTextDirection: direction,
      ),
      alignment: alignment,
      context: context,
    );
  }

  /// 失败提示Toast
  static void showFail(String? text,
      {IconTextDirection direction = IconTextDirection.horizontal,
      required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
      _DrsIconTextToast(
        text: text,
        iconData: Icons.close,
        iconTextDirection: direction,
      ),
      alignment: alignment,
      context: context,
    );
  }

  /// 带文案的加载Toast
  static void showLoading(
      {required BuildContext context,
      String? text,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(
        _DrsToastLoading(
          text: text,
        ),
        context: context,
        alignment: alignment,
        duration: DrsToast._infiniteDuration);
  }

  /// 不带文案的加载Toast
  static void showLoadingWithoutText(
      {required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
      AlignmentGeometry alignment = Alignment.center}) {
    _showOverlay(const _DrsToastLoadingWithoutText(),
        alignment: alignment,
        context: context,
        duration: DrsToast._infiniteDuration);
  }

  /// 进度条加载Toast
  static void showLoadingProgress(double value,
      {required BuildContext context,
      Duration duration = DrsToast._defaultDisPlayDuration,
        String? text,
      AlignmentGeometry alignment = Alignment.center}) {
    if (_progressKey == null) {
      GlobalKey<DrsLoadingProgressState> progressKey =
          GlobalKey<DrsLoadingProgressState>();
      Widget w = _DrsLoadingProgress(
        key: progressKey,
        value: value,
        text: text,
      );
      _showOverlay(w, context: context, duration: DrsToast._infiniteDuration);
      _progressKey = progressKey;
    }
    // update progress
    _progressKey?.currentState?.updateProgress(min(1.0, value));
  }

  /// 关闭加载Toast
  static void dismissLoading() {
    _cancel();
  }

  static void _showOverlay(Widget? widget,
      {required BuildContext context,
      Duration? duration,
      AlignmentGeometry alignment = Alignment.center}) {
    Duration d = duration ?? DrsToast._defaultDisPlayDuration;
    _cancel();
    _showing = true;
    var overlayState = Overlay.of(context);
    _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => SafeArea(
              child: Align(
                alignment: alignment,
                child: AnimatedOpacity(
                  opacity: _showing ? 1.0 : 0.0,
                  duration: _showing
                      ? const Duration(milliseconds: 100)
                      : const Duration(milliseconds: 200),
                  child: DefaultTextStyle(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: $styles.text.subTitle.copyWith(color: Colors.white),
                    child: widget ?? const SizedBox(),
                  ),
                ),
              ),
            ));
    if (_overlayEntry != null) {
      overlayState.insert(_overlayEntry!);
    }
    _startTimer(d);
  }

  static void _cancel() {
    _timer?.cancel();
    _timer = null;
    _disposeTimer?.cancel();
    _disposeTimer = null;
    _overlayEntry?.remove();
    _overlayEntry = null;
    _showing = false;
  }

  static void _startTimer(Duration duration) {
    _timer?.cancel();
    _disposeTimer?.cancel();
    _timer = Timer(duration, () {
      _showing = false;
      _overlayEntry?.markNeedsBuild();
      _timer = null;
      _disposeTimer = Timer(const Duration(milliseconds: 200), () {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _disposeTimer = null;
      });
    });
  }

  static OverlayEntry? _overlayEntry;
  static bool _showing = false;
  static Timer? _timer;
  static Timer? _disposeTimer;
  static const Duration _defaultDisPlayDuration = Duration(milliseconds: 700);
  static const Duration _infiniteDuration = Duration(seconds: 99999999);
  static GlobalKey<DrsLoadingProgressState>? _progressKey;
}

class _DrsLoadingProgress extends StatefulWidget {
  final double value;
  final String? text;
  const _DrsLoadingProgress({required this.value, this.text, Key? key})
      : super(key: key);

  @override
  State<_DrsLoadingProgress> createState() => DrsLoadingProgressState();
}

class DrsLoadingProgressState extends State<_DrsLoadingProgress> {
  late double _value = widget.value;

  void updateProgress(double value) {
    setState(() {
      _value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: $styles.borderRadius.all8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            EasyLoadingProgress(
              value: _value,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(widget.text ?? '加载中...')
          ],
        ));
  }
}

class _DrsToastLoading extends StatelessWidget {
  final String? text;
  const _DrsToastLoading({this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 110,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: $styles.borderRadius.all8,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            const DrsCircleIndicator(
              color: Colors.white,
              size: 26,
              lineWidth: 4,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(text ?? '加载中...')
          ],
        ));
  }
}

class _DrsIconTextToast extends StatelessWidget {
  final String? text;
  final IconData? iconData;
  final IconTextDirection iconTextDirection;
  const _DrsIconTextToast(
      {this.text,
      this.iconData,
      this.iconTextDirection = IconTextDirection.horizontal});

  Widget buildHorizontalWidgets(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 310, maxHeight: 94),
      child: Container(
          padding: const EdgeInsets.fromLTRB(24, 14, 24, 14),
          decoration: BoxDecoration(
            color: bgBlackColor,
            borderRadius: $styles.borderRadius.all8,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                iconData,
                size: 24,
                color: Colors.white,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                text ?? '',
              )
            ],
          )),
    );
  }

  Widget buildVerticalWidgets(BuildContext context) {
    return ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 136, maxHeight: 130),
        child: Container(
            height: 110,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: bgBlackColor,
              borderRadius: $styles.borderRadius.all8,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconData,
                  size: 32,
                  color: Colors.white,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  text ?? '',
                )
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return iconTextDirection == IconTextDirection.horizontal
        ? buildHorizontalWidgets(context)
        : buildVerticalWidgets(context);
  }
}

class _DrsToastLoadingWithoutText extends StatelessWidget {
  const _DrsToastLoadingWithoutText();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 80,
        height: 80,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: $styles.borderRadius.all8,
        ),
        child: const DrsCircleIndicator(
          color: Colors.white,
          size: 26,
          lineWidth: 4,
        ));
  }
}

class _DrsTextToast extends StatelessWidget {
  final String? text;
  const _DrsTextToast({this.text});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 310, maxHeight: 194),
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
        decoration: BoxDecoration(
          color: bgBlackColor,
          borderRadius: $styles.borderRadius.all8,
        ),
        child: Text(
          text ?? '',
          maxLines: 3,
        ),
      ),
    );
  }
}
