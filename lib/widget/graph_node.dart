import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  Color color;

  Item(
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
