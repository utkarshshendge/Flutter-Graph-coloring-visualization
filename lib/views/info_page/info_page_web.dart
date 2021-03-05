import 'package:daa/views/input_page/graph_input_matrix_web.dart';
import 'package:flutter/material.dart';
import 'package:daa/theme/customtheme.dart';
import 'package:daa/theme/customtheme.dart';

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
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                              text: TextSpan(
                                  text:
                                      "Graph coloring algorithm\nVisualization.",
                                  style: TextStyle(
                                      fontFamily: "CM",
                                      fontSize: 60,
                                      color: Colors.white),
                                  children: <TextSpan>[
                                TextSpan(
                                  text: "\nCoded in Dart.",
                                  style: TextStyle(
                                      fontFamily: "CM",
                                      fontSize: 40,
                                      color: Colors.white54),
                                ),
                              ])),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              "To proceed enter number of vertices (preferably single digit number >0).\nApp uses adjacency matrix representation to solve vertex coloring problem uing Recursive Backtracking and Greedy approach.",
                              style: TextStyle(
                                  fontSize: 15, color: CustomTheme.customCyan)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    Column(
                      children: <Widget>[
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
                                labelText: "Enter number of vertices",
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
                              if (text != null)
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => GraphInputWeb(
                                            vertexCount: int.parse(text),
                                          )),
                                );
                            },
                            child: Text("Proceed")),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
