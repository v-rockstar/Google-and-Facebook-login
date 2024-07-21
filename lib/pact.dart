import 'package:flutter/material.dart';

class PainterBrushBar extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Gradient gradient = LinearGradient(
      colors: [Colors.amber, Colors.indigoAccent],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Rect colorBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    final Paint paint = Paint()..shader = gradient.createShader(colorBounds);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.arcToPoint(Offset(size.width * 0.85, size.height * 0.8),
        radius: const Radius.circular(70), clockwise: false);
    path.lineTo(size.width * 0.15, size.height * 0.8);
    path.arcToPoint(Offset(0, size.height * 0.6),
        radius: const Radius.circular(70), clockwise: true);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PP extends StatelessWidget {
  const PP({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: CustomPaint(
            size: Size(MediaQuery.sizeOf(context).width, 200),
            painter: PainterBrushBar(),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: const Text('data'),
            ),
          )),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
