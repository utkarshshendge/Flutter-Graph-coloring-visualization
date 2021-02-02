import 'package:daa/views/input_page/graph_input_matrix_web.dart';
import 'package:flutter/material.dart';
import 'package:daa/views/input_page/graph_input_matrix.dart';

class InfoPageWeb extends StatefulWidget {
  @override
  _InfoPageWebState createState() => _InfoPageWebState();
}

class _InfoPageWebState extends State<InfoPageWeb> {
  String text = '';
  TextEditingController _textFieldController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A3465),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  Column(
                    children: <Widget>[
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
                            labelText: "Tap here to enter number of vertices.",
                            labelStyle:
                                TextStyle(color: Colors.white, fontSize: 20),
                            hintText: "4 or 5 or 8?",
                            hintStyle:
                                TextStyle(color: Colors.white, fontSize: 10)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  FlatButton(
                      color: Color(0xffFC4A71),
                      onPressed: () {
                        if (text != null)
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GraphInputWeb(
                                      vertexCount: int.parse(text),
                                    )),
                          );
                      },
                      child: Text("Proceed"))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
