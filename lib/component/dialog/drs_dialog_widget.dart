/*
 * Created by haozhicao@tencent.com on 6/20/22.
 * td_dialog_widget.dart
 * 
 */

import 'package:drs_ui_kit/drs_ui_kit.dart';
import 'package:drs_ui_kit/styles/drs_colors.dart';
import 'package:flutter/material.dart';

/// DrsDialog手脚架
class DrsDialogScaffold extends StatelessWidget {
  const DrsDialogScaffold({
    Key? key,
    required this.body,
    this.showCloseButton,
    this.backgroundColor = Colors.white,
    this.radius = 12.0,
  }) : super(key: key);

  /// Dialog主体
  final Widget body;

  /// 显示右上角关闭按钮
  final bool? showCloseButton;

  /// 背景色
  final Color backgroundColor;

  /// 圆角
  final double radius;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: $styles.text.headlineSmall,
      child: Center(
        child: Container(
          width: 311,
          decoration: BoxDecoration(
            color: backgroundColor, // 底色
            borderRadius: BorderRadius.all(Radius.circular(radius)),
          ),
          child: Stack(
            children: [
              body,
              showCloseButton ?? false
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          width: 38,
                          height: 38,
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 22,
                              color: bgBlackColor,
                            ),
                          ),
                        ),
                      ))
                  : Container(height: 0)
            ],
          ),
        ),
      ),
    );
  }
}

/// 弹窗标题
class DrsDialogTitle extends StatelessWidget {
  const DrsDialogTitle({
    Key? key,
    this.title = '对话框标题',
    this.titleColor = Colors.black,
  }) : super(key: key);

  /// 标题颜色
  final Color titleColor;

  /// 标题文字
  final String title;

  @override
  Widget build(BuildContext context) {
    // 标题和内容不能同时为空
    return Text(
      title,
      textAlign: TextAlign.center,
      style: $styles.text.headlineSmall,
    );
  }
}

/// 弹窗内容
class DrsDialogContent extends StatelessWidget {
  const DrsDialogContent({
    Key? key,
    this.content = '当前弹窗内容',
    this.contentColor = const Color(0x99000000),
  }) : super(key: key);

  /// 标题颜色
  final Color contentColor;

  /// 标题文字
  final String content;

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: $styles.text.headlineSmall
          .copyWith(fontWeight: FontWeight.w300, color: contentColor),
    );
  }
}

/// 弹窗信息
class DrsDialogInfoWidget extends StatelessWidget {
  const DrsDialogInfoWidget({
    Key? key,
    this.title,
    this.titleColor = Colors.black,
    this.padding = const EdgeInsets.fromLTRB(24, 32, 24, 0),
    this.content,
    this.contentColor,
    this.contentMaxHeight = 0,
  })  : assert((title != null || content != null)),
        super(key: key);

  /// 标题
  final String? title;

  /// 标题颜色
  final Color titleColor;

  /// 内容
  final String? content;

  /// 内容颜色
  final Color? contentColor;

  /// 内容的最大高度，默认为0，也就是不限制高度
  final double contentMaxHeight;

  /// 内容的内边距
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          title != null
              ? Text(
                  title ?? '',
                  style: $styles.text.title,
                )
              : Container(),
          content == null
              ? Container()
              : Container(
                  padding: EdgeInsets.fromLTRB(
                      0, (title != null && content != null) ? 8.0 : 0, 0, 0),
                  constraints: contentMaxHeight > 0
                      ? BoxConstraints(
                          maxHeight: contentMaxHeight,
                        )
                      : null,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: DrsDialogContent(
                        content: content!,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
//
// /// 横向排列的两个按钮
// class HorizontalNormalButtons extends StatelessWidget {
//   const HorizontalNormalButtons({
//     Key? key,
//     required this.leftBtn,
//     required this.rightBtn,
//   }) : super(key: key);
//
//   /// 左按钮
//   final DrsDialogButtonOptions leftBtn;
//
//   /// 右按钮
//   final DrsDialogButtonOptions rightBtn;
//
//   @override
//   Widget build(BuildContext context) {
//     // 标题和内容不能同时为空
//     return Container(
//       padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: DrsDialogButton(
//               buttonText: leftBtn.title,
//               buttonTextColor:
//                   leftBtn.titleColor ?? DrsTheme.of(context).brandNormalColor,
//               buttonStyle: leftBtn.style,
//               buttonType: leftBtn.type,
//               buttonTheme: leftBtn.theme,
//               height: leftBtn.height,
//               buttonTextFontWeight: leftBtn.fontWeight ?? FontWeight.w600,
//               onPressed: () {
//                 Navigator.pop(context);
//                 leftBtn.action();
//               },
//             ),
//           ),
//           const DrsDivider(
//             width: 12,
//             color: Colors.transparent,
//           ),
//           Expanded(
//             child: DrsDialogButton(
//               buttonText: rightBtn.title,
//               buttonTextColor:
//                   rightBtn.titleColor ?? DrsTheme.of(context).whiteColor1,
//               buttonStyle: rightBtn.style,
//               buttonType: rightBtn.type,
//               buttonTheme: rightBtn.theme,
//               height: rightBtn.height,
//               buttonTextFontWeight: rightBtn.fontWeight ?? FontWeight.w600,
//               onPressed: () {
//                 Navigator.pop(context);
//                 rightBtn.action();
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// /// 左右横向文字按钮，顶部和中间有分割线
// class HorizontalTextButtons extends StatelessWidget {
//   const HorizontalTextButtons({
//     Key? key,
//     required this.leftBtn,
//     required this.rightBtn,
//   }) : super(key: key);
//
//   /// 左按钮
//   final DrsDialogButtonOptions leftBtn;
//
//   /// 右按钮
//   final DrsDialogButtonOptions rightBtn;
//
//   @override
//   Widget build(BuildContext context) {
//     // 标题和内容不能同时为空
//     return Column(
//       children: [
//         const DrsDivider(height: 1),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               child: DrsDialogButton(
//                 buttonText: leftBtn.title,
//                 buttonTextColor:
//                     leftBtn.titleColor ?? DrsTheme.of(context).fontGyColor1,
//                 buttonStyle: leftBtn.style,
//                 buttonType: leftBtn.type ?? DrsButtonType.text,
//                 buttonTheme: leftBtn.theme,
//                 height: leftBtn.height,
//                 buttonTextFontWeight: leftBtn.fontWeight,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   leftBtn.action();
//                 },
//               ),
//             ),
//             const DrsDivider(
//               width: 1,
//               height: 56,
//             ),
//             Expanded(
//               child: DrsDialogButton(
//                 buttonText: rightBtn.title,
//                 buttonTextColor:
//                     rightBtn.titleColor ?? DrsTheme.of(context).brandNormalColor,
//                 buttonStyle: leftBtn.style,
//                 buttonType: leftBtn.type ?? DrsButtonType.text,
//                 buttonTheme: leftBtn.theme ?? DrsButtonTheme.primary,
//                 height: rightBtn.height,
//                 buttonTextFontWeight: rightBtn.fontWeight ?? FontWeight.w600,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   rightBtn.action();
//                 },
//               ),
//             ),
//           ],
//         )
//       ],
//     );
//   }
// }
//
// /// 弹窗标题
// class DrsDialogButton extends StatelessWidget {
//   const DrsDialogButton({
//     Key? key,
//     this.buttonText = '按钮',
//     this.buttonTextColor,
//     this.buttonTextFontWeight = FontWeight.w600,
//     this.buttonStyle,
//     this.buttonType,
//     this.buttonTheme,
//     required this.onPressed,
//     this.height = 40.0,
//     this.width,
//     this.isBlock = true,
//   }) : super(key: key);
//
//   /// 按钮文字
//   final String? buttonText;
//
//   /// 按钮文字颜色
//   final Color? buttonTextColor;
//
//   /// 按钮文字粗细
//   final FontWeight? buttonTextFontWeight;
//
//   /// 按钮样式
//   final DrsButtonStyle? buttonStyle;
//
//   /// 按钮类型
//   final DrsButtonType? buttonType;
//
//   /// 按钮主题
//   final DrsButtonTheme? buttonTheme;
//
//   /// 按钮宽度
//   final double? width;
//
//   /// 按钮高度
//   final double? height;
//
//   /// 按钮高度
//   final bool isBlock;
//
//   /// 点击
//   final Function() onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return DrsButton(
//       onTap: onPressed,
//       style: buttonStyle,
//       type: buttonType ?? DrsButtonType.fill,
//       theme: buttonTheme,
//       text: buttonText,
//       textStyle: TextStyle(fontWeight: buttonTextFontWeight, color: buttonTextColor),
//       width: width,
//       height: height,
//       isBlock: isBlock,
//       margin: EdgeInsets.zero,
//     );
//   }
// }
