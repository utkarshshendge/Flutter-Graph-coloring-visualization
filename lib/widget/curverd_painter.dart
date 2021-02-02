import 'package:flutter/material.dart';

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
