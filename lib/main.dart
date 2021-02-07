import 'package:daa/theme/customtheme.dart';
import 'package:daa/views/info_page/info_page_web.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'views/info_page/info_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Graph Coloring Visualization',
      theme: CustomTheme().buildTheme(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            alignment: Alignment.center,
            child: ScreenTypeLayout(
              mobile: InfoPage(),
              tablet: InfoPageWeb(),
            ),
          ),
        ),
      ),
    );
  }
}
