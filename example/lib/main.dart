import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:drs_ui_kit/drs_ui_kit.dart';

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
    return MaterialApp(
      home: App());
  }
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Builder(
          builder: (context) {
            return Center(
              child: Column(
                children: [
                  IconButton(onPressed: (){
                    DrsToast.showLoading(text:'轻提示文字内容1', context: context);
                  }, icon: Icon(Icons.add)),

                  IconButton(onPressed: (){
                    showGeneralDialog(
                      context: context,
                      pageBuilder: (BuildContext buildContext, Animation<double> animation,
                          Animation<double> secondaryAnimation) {
                        return DrsAlertDialog(
                          title: "对话框标题",
                          content: "告知当前状态、信息和解决方法，等内容。描述尽可能控制在三行内。",
                        );
                      },
                    );
                  }, icon: Icon(Icons.add)),
                  SizedBox(
                    height: 20,
                    child: Container(
                      alignment: Alignment.center,
                      child: const DrsDivider(),
                    ),
                  ),
                  Column(
                    children: const [
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
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          '文字信息',
                        ),
                        const DrsDivider(
                          width: 0.5,
                          height: 12,
                          margin: EdgeInsets.only(left: 16, right: 16),
                        ),
                        Text('文字信息',),
                        const DrsDivider(
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
                  Column(
                    children:  [
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
              ),

            );
          }
      ),
    );
  }
}
