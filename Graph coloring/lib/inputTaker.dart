import 'package:flutter/material.dart';

import 'homepage.dart';

class InputTaker extends StatefulWidget {
  final int vertexCount;

  const InputTaker({Key key, this.vertexCount}) : super(key: key);
  @override
  _InputTakerState createState() => _InputTakerState();
}

class _InputTakerState extends State<InputTaker> {
  List<int> displayExOh = [];
  var matrix;
  var adjMatrix;
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
  tapped(int index) {
    setState(() {
      displayExOh[index] == 0 ? displayExOh[index] = 1 : displayExOh[index] = 0;
    });
  }

  String text = "3";
  TextEditingController _textFieldController = TextEditingController();

  convertToMatrix() {
    matrix = List.generate(
        widget.vertexCount,
        (i) => List.generate(widget.vertexCount,
            (j) => displayExOh[j + i * widget.vertexCount]));
    adjMatrix = matrix;
    print(matrix);
    adjMatrix = [
      [0, 1, 0, 0, 1, 1],
      [1, 0, 0, 1, 1, 0],
      [0, 0, 0, 1, 1, 0],
      [0, 1, 1, 0, 0, 0],
      [1, 1, 1, 0, 0, 1],
      [1, 0, 0, 0, 1, 0]
    ];
  }

  @override
  void initState() {
    for (int i = 0; i < widget.vertexCount * widget.vertexCount; i++) {
      displayExOh.add(0);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A3465),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 500,
              child: GridView.builder(
                  itemCount: widget.vertexCount * widget.vertexCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: widget.vertexCount),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        tapped(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffFC4A71))),
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
            FlatButton(
                color: Color(0xff45D3C2),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemsScene(
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
                        builder: (context) => ItemsScene(
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
                  labelStyle: TextStyle(color: Colors.white, fontSize: 30),
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: "3 (By default)",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 10)),
            ),
            FlatButton(
                color: Color(0xffFC4A71),
                onPressed: () {
                  convertToMatrix();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ItemsScene(
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
    );
  }
}
