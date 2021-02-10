import 'package:flutter/material.dart';
import 'package:daa/model/item_model.dart';
import 'package:daa/widget/curverd_painter.dart';
import 'package:daa/widget/graph_node.dart';

class HomePageWeb extends StatefulWidget {
  final int vertexCount;
  final int mcolor;

  final matrix;

  const HomePageWeb({Key key, this.vertexCount, this.mcolor, this.matrix})
      : super(key: key);

  @override
  _HomePageWebState createState() => _HomePageWebState();
}

class _HomePageWebState extends State<HomePageWeb> {
  int colorCount = 0;
  List defaultColors = List.filled(11, Colors.white);

  List<ItemModel> items = [];
  List colorList = [
    Color(0xffF6EE3F),
    Color(0xffFF5436),
    Color(0xff008FFF),
    Color(0xff50E3C2),
    Color(0xffB1F96E),
    Color(0xffBB14D9),
    Colors.orange
  ];

  void printSolution(List color) {
    print("Solution Exists:"
        " Following are the assigned colors \n");
    for (int i = 0; i < widget.vertexCount; i++) print(color[i]);
    print("\n");
  }

//Recursive algorithm  ==================================================================================
  bool isSafe(graph, List color, int vertexCount) {
    for (int i = 0; i < vertexCount; i++)
      for (int j = i + 1; j < vertexCount; j++)
        if (graph[i][j] == 1 && color[j] == color[i]) return false;
    return true;
  }

  Future<bool> graphColoring(
    graph,
    int m,
    int i,
    List color,
    List<ItemModel> items,
    int vertexCount,
  ) async {
    if (i == vertexCount) {
      if (isSafe(graph, color, vertexCount)) {
        printSolution(color);
        return true;
      }

      return false;
    }

    for (int j = 1; j <= m; j++) {
      color[i] = colorList[j];
      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        setState(() {
          colorCount = colorCount + 1;
        });
        items[i].color = color[i];
      });
      if (await graphColoring(graph, m, i + 1, color, items, vertexCount))
        return true;
    }

    return false;
  }

  rescursiveUtility(var graph, List<ItemModel> items, int vertexCount) async {
    int m = widget.mcolor;
    List<Color> color = List.filled(vertexCount, Colors.white);

    graphColoring(
      graph,
      m,
      0,
      color,
      items,
      vertexCount,
    );
  }
//Backtracking algorithm ==================================================================================

  Future<bool> backtrackIsSafe(
      int v, graph, List color, int c, int vertexCount) async {
    for (int i = 0; i < vertexCount; i++) {
      if (graph[v][i] == 1 && colorList[c] == color[i]) return false;
    }
    return true;
  }

  Future<bool> backtrackGraphColoringUtil(graph, int m, List color,
      int vertexCount, v, List<ItemModel> items) async {
    if (v == vertexCount) return true;

    for (int c = 1; c <= m; c++) {
      if (await backtrackIsSafe(v, graph, color, c, vertexCount)) {
        color[v] = colorList[c];
        await Future.delayed(Duration(milliseconds: 500));
        setState(() {
          colorCount = colorCount + 1;
          items[v].color = color[v];
        });

        if (await backtrackGraphColoringUtil(
                graph, m, color, vertexCount, v + 1, items) ==
            true) return true;
        color[v] = Colors.white;
      }
      //
    }

    return false;
  }

  baktrackingStart(var graph, List<ItemModel> items, int vertexCount) {
    int m = widget.mcolor;
    List<Color> color = List.filled(vertexCount, Colors.white);
    backtrackGraphColoringUtil(graph, m, color, vertexCount, 0, items);
  }

//Greedy algorithm  ==================================================================================

  greedyColoring(List<List> adj, int N, List<ItemModel> items) async {
    List<Color> result = new List<Color>(N);
    List<int> resultIndex = new List<int>(N);

    // Assign the first color to first vertex
    result[0] = Colors.red;
    resultIndex[0] = 0;
    //await Future.delayed(Duration(milliseconds: 500));

    setState(() {
      items[0].color = result[0];
    });

    for (int u = 1; u < N; u++) {
      result[u] = Colors.white;
      resultIndex[u] = -1;
    } // no color is assigned to u

    List<bool> available = new List<bool>(N);
    for (int cr = 0; cr < N; cr++) available[cr] = true;

    for (int u = 1; u < N; u++) {
      for (int i = 0; i < N; i++) {
        if (widget.matrix[u][i] == 1) {
          if (resultIndex[i] != -1) {
            available[resultIndex[i]] = false;
          }
        }
      }

      int cr;
      for (cr = 0; cr < N; cr++) {
        if (available[cr] == true) break;
      }

      resultIndex[u] = cr;

      result[u] = colorList[cr];
      await Future.delayed(Duration(milliseconds: 500));

      setState(() {
        colorCount = colorCount + 1;
        items[u].color = result[u];
      });

      for (int cr = 0; cr < N; cr++) {
        available[cr] = true;
      }
    }

    for (int u = 0; u < N; u++) print("Vertex $u  color ${result[u]}");
    print("\n");
  }

  greedyMain(int N, List<ItemModel> items) {
    var adj = List.generate(N, (i) => []);

    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        if (widget.matrix[i][j] == 1) {
          adj[i].add(j);
        }
      }
    }
    print(adj);
    greedyColoring(adj, N, items);
  }

//---------------------------------------------------------------------------------------------------
  Function onDragStart(int index) => (x, y) {
        setState(() {
          items[index] = items[index].copyWithNewOffset(Offset(x, y));
        });
      };
  @override
  void initState() {
    for (var k = 0; k < widget.vertexCount; k++) {
      items.add(ItemModel(
          offset: Offset(200 + 10 * k.toDouble(), 150),
          text: '$k',
          color: defaultColors[k]));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Container(
            color: Color(0xff1A2744),
            height: 500,
            child: Stack(
              children: <Widget>[
                CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: CurvedPainter(
                      offsets: items.map((item) => item.offset).toList(),
                      matrix: widget.matrix,
                      vertexCount: widget.vertexCount),
                ),
                ..._buildItems(),
              ],
            ),
          ),
          Text("$colorCount",
              style: TextStyle(color: Colors.white, fontSize: 40)),
          Row(
            children: [
              Expanded(
                child: RichText(
                    text: TextSpan(
                        text: "Graph coloring algorithm\nVisualization.",
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FlatButton(
                onPressed: () {
                  setState(() {
                    colorCount = 0;
                  });
                  rescursiveUtility(widget.matrix, items, widget.vertexCount);
                },
                child: Text("Recursive", style: TextStyle(color: Colors.white)),
                color: Color(0xff684AFF),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    colorCount = 0;
                  });
                  baktrackingStart(widget.matrix, items, widget.vertexCount);
                },
                child: Text(
                  "Backtracking",
                  style: TextStyle(color: Colors.white),
                ),
                color: Color(0xff45D3C2),
              ),
              FlatButton(
                onPressed: () {
                  setState(() {
                    colorCount = 0;
                  });
                  greedyMain(widget.vertexCount, items);
                },
                child: Text("Greedy", style: TextStyle(color: Colors.white)),
                color: Color(0xffFC4A71),
              ),
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    final resultList = <Widget>[];
    items.asMap().forEach((ind, item) {
      resultList.add(Item(
          onDragStart: onDragStart(ind),
          offset: item.offset,
          text: item.text,
          color: item.color));
    });

    return resultList;
  }
}
