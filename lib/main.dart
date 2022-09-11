import 'package:flutter/material.dart';

import 'view/bottom_tab_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const Color canvasColor = Color.fromRGBO(236, 239, 241, 1);
  static const AppBarTheme appBarTheme = AppBarTheme(
      elevation: 1,
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 16,
      ));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
      title: 'Pi_Memorization',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: appBarTheme,
          canvasColor: canvasColor,
          textTheme: const TextTheme(
            headline1: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )),
      home: const BottomTabBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
