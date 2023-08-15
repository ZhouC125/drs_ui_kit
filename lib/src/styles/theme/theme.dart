
import 'package:drs_ui_kit/src/styles/drs_colors.dart';
import 'package:flutter/material.dart';

/// @description : 主题数据
/// @class : theme
/// @date :  2023/6/20 13:45
/// @name : achen
@immutable
class ThemeInfo {
  ///主题数据
  final ThemeData themeData = ThemeData(
    // useMaterial3:true,
    appBarTheme: const AppBarTheme(
      ///appbar主题
      backgroundColor: Colors.white,
      iconTheme: IconThemeData.fallback(),
      elevation: 0.2,
      shadowColor: Colors.white,
    ),

    ///tabbar主题
    tabBarTheme: const TabBarTheme(
      indicator: UnderlineTabIndicator(
        borderRadius: null,
        borderSide: BorderSide(
          width: 2,
          color: themeColor,
        ),
      ),
    ),
    primaryColor: Colors.white,
    canvasColor: Colors.white,
    primarySwatch: Colors.blue,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
  );
}