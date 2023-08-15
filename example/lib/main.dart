import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:drs_ui_kit/drs_ui_kit.dart';

import 'page/ui_widget_detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: App());
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  /// 设置组件的标题和用例，跳转到新的页面进行展示
  Widget buildItem(
    BuildContext context,
    String title,
    List<Widget>? children, {
    VoidCallback? onTap,
  }) {
    return Tapper(
      onTap: () {
        if (onTap != null) {
          onTap();
        } else {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (_) =>
                  UIWidgetDetailPage(title: title, children: children ?? []),
            ),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          children: <Widget>[
            Expanded(child: Text(title)),
            const Icon(Icons.chevron_right, color: subColor, size: 17),
          ],
        ),
      ),
    );
  }

  Widget actionSheet(BuildContext context) => buildItem(
        context,
        'Toast提示',
        [
          _textBtn('普通提示', () => DrsToast.showText('普通提示', context: context)),
          _textBtn(
              '图标提示',
              () => DrsToast.showIconText('图标提示',
                  icon: Icons.access_time, context: context)),
          _textBtn(
              '竖图标提示',
              () => DrsToast.showIconText('图标提示',
                  icon: Icons.access_time,
                  context: context,
                  direction: IconTextDirection.vertical)),
          _textBtn(
              '加载提示', () => DrsToast.showLoadingWithoutText(context: context)),
          _textBtn('文字加载提示', () => DrsToast.showLoading(context: context)),
          _textBtn('成功提示Toast',
              () => DrsToast.showSuccess('成功提示Toast', context: context)),
          _textBtn('警告提示Toast',
              () => DrsToast.showWarning('警告提示Toast', context: context)),
          _textBtn('失败提示Toast',
              () => DrsToast.showFail('失败提示Toast', context: context)),
          _textBtn('进度条加载Toast',
              () => DrsToast.showLoadingProgress(0.2, context: context)),
        ],
      );

  Widget divider(BuildContext context) => buildItem(
        context,
        'Divider分割线',
        [
          SizedBox(
            height: 20,
            child: Container(
              alignment: Alignment.center,
              child: const DrsDivider(),
            ),
          ),
          const Column(
            children: [
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.left,
              ),
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.center,
              ),
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.right,
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 16,
                ),
                Text(
                  '文字信息',
                ),
                DrsDivider(
                  width: 0.5,
                  height: 12,
                  margin: EdgeInsets.only(left: 16, right: 16),
                ),
                Text(
                  '文字信息',
                ),
                DrsDivider(
                  width: 0.5,
                  height: 12,
                  margin: EdgeInsets.only(left: 16, right: 16),
                  isDashed: true,
                  direction: Axis.vertical,
                ),
                Text('文字信息'),
              ],
            ),
          ),
          const Column(
            children: [
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                isDashed: true,
              ),
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.left,
                isDashed: true,
              ),
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.center,
                isDashed: true,
              ),
              SizedBox(
                height: 20,
              ),
              DrsDivider(
                text: '文字信息',
                alignment: TextAlignment.right,
                isDashed: true,
              ),
            ],
          )
        ],
      );

  Widget _textBtn(String text, VoidCallback onTap) {
    return TextButton(onPressed: onTap, child: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ui_kit例子'),
      ),
      body: ListView(
        children: <Widget>[
          actionSheet(context),
          divider(context),
        ].expand((e) => [e, const DrsDivider()]).toList(),
      ),
    );
  }
}
