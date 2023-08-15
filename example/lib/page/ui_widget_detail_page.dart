import 'package:drs_ui_kit/drs_ui_kit.dart';
import 'package:flutter/material.dart';

class UIWidgetDetailPage extends StatelessWidget {
  const UIWidgetDetailPage(
      {Key? key, required this.title, required this.children})
      : super(key: key);

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: blackColor, fontSize: 18, fontWeight: FontWeight.bold),maxLines: 3),
        elevation: 0.2,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.only(top: 10),
        itemBuilder: (c, index) => children[index],
        separatorBuilder: (c, i) => const DrsDivider(),
        itemCount: children.length,
      ),
    );
  }
}
