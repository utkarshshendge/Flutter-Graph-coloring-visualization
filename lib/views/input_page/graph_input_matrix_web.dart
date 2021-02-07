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
  Color bgColor = Colors.yellow;
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
            padding: const EdgeInsets.all(10.0),
            child: Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                      "Fill in the adjacency matrix.Remember, indexing starts from zero and when there is a node from 0-"),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                    child: Container(
                      height: 600,
                      width: 600,
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
                                    border:
                                        Border.all(color: Color(0xffFC4A71))),
                                child: Center(
                                  child: Text(
                                    "${displayExOh[index]}",
                                    style: TextStyle(
                                        color: Color(0xff45D3C2), fontSize: 40),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  FlatButton(
                      color: Color(0xff45D3C2),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage(
                                    vertexCount: 5,
                                    matrix: exampleMatrixOne,
                                    mcolor: 3,
                                  )),
                        );
                      },
                      child: Text('Sample Matrix 1')),
                  FlatButton(
                      color: Color(0xff45D3C2),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage(
                                    vertexCount: 5,
                                    matrix: exampleMatrixTwo,
                                    mcolor: 3,
                                  )),
                        );
                      },
                      child: Text('Sample Matrix 2')),
                  TextField(
                    onChanged: (value) {
                      text = value;
                    },
                    cursorColor: Colors.pink[200],
                    maxLength: 2,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    controller: _textFieldController,
                    decoration: InputDecoration(
                        labelText: "Enter number of colors.",
                        labelStyle:
                            TextStyle(color: Colors.white, fontSize: 30),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "3 (By default)",
                        hintStyle:
                            TextStyle(color: Colors.white, fontSize: 10)),
                  ),
                  FlatButton(
                      color: Color(0xffFC4A71),
                      onPressed: () {
                        convertToMatrix();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Homepage(
                                    vertexCount: widget.vertexCount,
                                    matrix: matrix,
                                    mcolor: int.parse(text),
                                  )),
                        );
                      },
                      child: Text('Proceed')),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
