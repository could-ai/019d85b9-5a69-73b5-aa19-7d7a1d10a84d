import 'package:flutter/material.dart';
import 'dart:math';

class ShapesPage extends StatelessWidget {
  const ShapesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('أشكال هندسية ملونة'),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 1 / 1.414, // A4 aspect ratio
          child: Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: CustomPaint(
              painter: ShapesPainter(),
            ),
          ),
        ),
      ),
    );
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = Random(42); // Fixed seed for consistent layout
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
      Colors.pink,
      Colors.teal,
      Colors.cyan,
      Colors.indigo,
      Colors.amber,
      Colors.lime,
      Colors.brown,
    ];

    // Draw grid of shapes
    int rows = 6;
    int cols = 4;
    double cellWidth = size.width / cols;
    double cellHeight = size.height / rows;

    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        double centerX = j * cellWidth + cellWidth / 2;
        double centerY = i * cellHeight + cellHeight / 2;
        double radius = min(cellWidth, cellHeight) * 0.35;

        Paint paint = Paint()
          ..color = colors[random.nextInt(colors.length)]
          ..style = PaintingStyle.fill;

        int shapeType = random.nextInt(4); // 0: Circle, 1: Square, 2: Triangle, 3: Pentagon

        canvas.save();
        canvas.translate(centerX, centerY);
        
        // Add slight random rotation
        canvas.rotate((random.nextDouble() - 0.5) * 0.5);

        switch (shapeType) {
          case 0:
            canvas.drawCircle(Offset.zero, radius, paint);
            break;
          case 1:
            canvas.drawRect(
              Rect.fromCenter(center: Offset.zero, width: radius * 2, height: radius * 2),
              paint,
            );
            break;
          case 2:
            Path path = Path();
            path.moveTo(0, -radius);
            path.lineTo(radius * 0.866, radius * 0.5);
            path.lineTo(-radius * 0.866, radius * 0.5);
            path.close();
            canvas.drawPath(path, paint);
            break;
          case 3:
            Path path = Path();
            for (int k = 0; k < 5; k++) {
              double angle = (k * 2 * pi / 5) - pi / 2;
              double x = radius * cos(angle);
              double y = radius * sin(angle);
              if (k == 0) {
                path.moveTo(x, y);
              } else {
                path.lineTo(x, y);
              }
            }
            path.close();
            canvas.drawPath(path, paint);
            break;
        }
        canvas.restore();
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
