import 'package:flutter/material.dart';

class ItemsScene extends StatefulWidget {
  final int vertexCount;
  final int mcolor;

  final matrix;

  const ItemsScene({Key key, this.vertexCount, this.matrix, this.mcolor})
      : super(key: key);
  @override
  _ItemsSceneState createState() => _ItemsSceneState();
}

var adjMatrix;
Stopwatch executionTime = new Stopwatch();

int colorCount = 0;
List defaultColors = [
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white,
  Colors.white
];

class _ItemsSceneState extends State<ItemsScene> {
  List<ItemModel> items = [];
  List colorList = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.brown,
    Colors.blue,
    Colors.purpleAccent,
    Colors.orange
  ];

  void printSolution(List color) {
    print("Solution Exists:"
        " Following are the assigned colors \n");
    for (int i = 0; i < widget.vertexCount; i++) print(color[i]);
    print("\n");
  }

//////================================================================================================================
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
      //  color[i] = Colors.white;
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
//////================================================================================================================

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

//===============================================================================================================================

  greedyColoring(List<List> adj, int N, List<ItemModel> items) async {
    Stopwatch executionTime = new Stopwatch();
    executionTime.start();
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
        if (adjMatrix[u][i] == 1) {
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
    executionTime.stop();
    print(
        "++++++++++++++++++++++++++++++++++++++++++  ${executionTime.elapsedMilliseconds}");
    for (int u = 0; u < N; u++) print("Vertex $u  color ${result[u]}");
    print("\n");
  }

  greedyMain(int N, List<ItemModel> items) {
    var adj = List.generate(N, (i) => []);

    for (int i = 0; i < N; i++) {
      for (int j = 0; j < N; j++) {
        if (adjMatrix[i][j] == 1) {
          adj[i].add(j);
        }
      }
    }
    print(adj);
    greedyColoring(adj, N, items);
  }

//===============================================================================================================================
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
    return Column(
      children: <Widget>[
        Container(
          color: Color(0xff2A3465),
          height: 600,
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
        Spacer(),
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
                  adjMatrix = widget.matrix;
                });
                greedyMain(widget.vertexCount, items);
                // baktrackingStart(widget.matrix, items, widget.vertexCount);
              },
              child: Text("Greedy", style: TextStyle(color: Colors.white)),
              color: Color(0xffFC4A71),
            ),
          ],
        )
      ],
    );
  }

  List<Widget> _buildItems() {
    final res = <Widget>[];
    items.asMap().forEach((ind, item) {
      res.add(_Item(
          onDragStart: onDragStart(ind),
          offset: item.offset,
          text: item.text,
          color: item.color));
    });

    return res;
  }
}

class _Item extends StatelessWidget {
  Color color;

  _Item(
      {Key key,
      this.offset,
      this.onDragStart,
      this.text,
      this.color,
      this.timesChanged});

  final double size = 50;
  final Offset offset;
  final Function onDragStart;
  final String text;
  final int timesChanged;

  _handleDrag(details) {
    print(details);
    var x = details.globalPosition.dx;
    var y = details.globalPosition.dy;
    onDragStart(x, y);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx - size / 2,
      top: offset.dy - size / 2,
      child: GestureDetector(
        onPanStart: _handleDrag,
        onPanUpdate: _handleDrag,
        child: Container(
          width: size,
          height: size,
          child: Center(
              child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.black),
          )),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  var matrix;

  final int vertexCount;
  CurvedPainter({
    this.offsets,
    this.matrix,
    this.vertexCount,
  });

  final List<Offset> offsets;

  @override
  void paint(Canvas canvas, Size size) {
    if (offsets.length > 1) {
      for (var i = 0; i < vertexCount; i++) {
        for (var j = 0; j < vertexCount; j++) {
          if (matrix[i][j] == 1) {
            canvas.drawLine(
              offsets[i],
              offsets[j],
              Paint()
                ..color = Colors.white
                ..strokeWidth = 2,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(CurvedPainter oldDelegate) => true;
}

class ItemModel {
  Color color;

  ItemModel({this.offset, this.text, this.color});

  final Offset offset;
  final String text;

  ItemModel copyWithNewOffset(Offset offset) {
    return ItemModel(offset: offset, text: text, color: color);
  }
}
