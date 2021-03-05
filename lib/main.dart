import 'package:daa/theme/customtheme.dart';
import 'package:daa/views/info_page/info_page_web.dart';
import 'package:flutter/material.dart';

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
        body: InfoPageWeb(),
        // body: Center(
        //   child: Container(
        //     alignment: Alignment.center,
        //     child: ScreenTypeLayout(

        //       tablet: InfoPageWeb(),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
