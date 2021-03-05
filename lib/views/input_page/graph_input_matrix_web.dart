import 'package:daa/theme/customtheme.dart';
import 'package:daa/views/homepage/homepage_web.dart';
import 'package:flutter/material.dart';

import 'package:daa/views/homepage/homepage.dart';
import 'package:responsive_builder/responsive_builder.dart';

class GraphInputWeb extends StatefulWidget {
  const GraphInputWeb({Key key, this.vertexCount}) : super(key: key);

  final int vertexCount;

  @override
  _GraphInputWebState createState() => _GraphInputWebState();
}

class _GraphInputWebState extends State<GraphInputWeb> {
  Color bgColor = Colors.black;
  List<int> displayExOh = [];
  var exampleMatrixOne = [
    [0, 1, 1, 0, 0],
    [1, 0, 1, 1, 0],
    [1, 1, 0, 1, 0],
    [0, 1, 1, 0, 1],
    [0, 0, 0, 1, 0]
  ];

  var exampleMatrixTwo = [
    [0, 1, 1, 0, 0],
    [1, 0, 1, 0, 1],
    [1, 1, 0, 0, 1],
    [0, 0, 0, 0, 1],
    [0, 1, 1, 1, 0]
  ];

  bool isdesktop = false;
  var matrix;
  String text = "3";

  TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    for (int i = 0; i < widget.vertexCount * widget.vertexCount; i++) {
      displayExOh.add(0);
    }
    super.initState();
  }

  tapped(int index) {
    setState(() {
      displayExOh[index] == 0 ? displayExOh[index] = 1 : displayExOh[index] = 0;
    });
  }

  convertToMatrix() {
    matrix = List.generate(
        widget.vertexCount,
        (i) => List.generate(widget.vertexCount,
            (j) => displayExOh[j + i * widget.vertexCount]));
    print(matrix);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(builder: (context, sizingInformation) {
      if (sizingInformation.deviceScreenType == DeviceScreenType.mobile) {
        isdesktop = false;
      } else {
        isdesktop = true;
      }
      return Scaffold(
        backgroundColor: bgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: RichText(
                          text: TextSpan(
                              text: "Fill the adjacency Matrix.",
                              style: TextStyle(
                                  fontFamily: "CM",
                                  fontSize: 60,
                                  color: Colors.white),
                              children: <TextSpan>[
                            TextSpan(
                              text:
                                  "\nFill in the adjacency matrix by clicking on gird block.\nEnter number of colors you wish to use.\nIndexing of matrix starts from 0, similar to 2-D array.\nYou can skip this part and proceed with the sample matrix.",
                              style: TextStyle(
                                  fontFamily: "CM",
                                  fontSize: 20,
                                  color: Colors.white70),
                            ),
                          ])),
                    ),
                    Column(
                      children: [
                        FlatButton(
                            color: CustomTheme.customCyan,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageWeb(
                                          vertexCount: 5,
                                          matrix: exampleMatrixOne,
                                          mcolor: 3,
                                        )),
                              );
                            },
                            child: Text('Sample Matrix 1')),
                        SizedBox(
                          height: 20,
                        ),
                        FlatButton(
                            color: CustomTheme.customCyan,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageWeb(
                                          vertexCount: 5,
                                          matrix: exampleMatrixTwo,
                                          mcolor: 3,
                                        )),
                              );
                            },
                            child: Text('Sample matrix 2')),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.height * 0.5,
                        child: GridView.builder(
                            itemCount: widget.vertexCount * widget.vertexCount,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: widget.vertexCount),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  tapped(index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.white)),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        "${displayExOh[index]}",
                                        style: TextStyle(
                                            color: Colors.redAccent,
                                            fontSize: 40),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 200,
                          child: TextField(
                            autofocus: true,
                            onChanged: (value) {
                              text = value;
                            },
                            cursorColor: Colors.redAccent,
                            keyboardType: TextInputType.number,
                            style: TextStyle(color: Colors.white),
                            controller: _textFieldController,
                            decoration: InputDecoration(
                                labelText: "Enter number of colors",
                                labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: "CM"),
                                hintStyle: TextStyle(
                                    color: Colors.white, fontSize: 10)),
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        FlatButton(
                            color: Color(0xffFC4A71),
                            onPressed: () {
                              convertToMatrix();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePageWeb(
                                          vertexCount: widget.vertexCount,
                                          matrix: matrix,
                                          mcolor: int.parse(text),
                                        )),
                              );
                            },
                            child: Text('Proceed'))
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
