import 'package:custom_painter/dialog.dart';
import 'package:flutter/material.dart';

class Circles extends StatelessWidget {
  const Circles({Key key, this.rectsAndPaint}) : super(key: key);

  final List<Map<Rect, Paint>> rectsAndPaint;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => onCircleTap(details, context),
      child: CustomPaint(
        painter: CirclePainter(rects: rectsAndPaint),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void onCircleTap(TapDownDetails details, BuildContext context) async {
    RenderBox box = context.findRenderObject();

    final offset = box.globalToLocal(details.globalPosition);

    final index = rectsAndPaint.lastIndexWhere(
      (rect) => checkIfRectangleContainsOffset(rect, offset),
    );

    await showColorNameDialogIfIndexFoundOrShowTappedCanvasDialog(context, index);
  }

  bool checkIfRectangleContainsOffset(Map<Rect, Paint> rectangleWithPaint, Offset offset) {
    var rect = rectangleWithPaint.entries.first.key;

    if ((rect.center - offset).distance < rect.shortestSide / 2) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> showColorNameDialogIfIndexFoundOrShowTappedCanvasDialog(BuildContext context, int index) async {
    switch (index) {
      case 0:
        await showSelectedCircleDialogBox(context, "You Tapped Red Color");
        break;
      case 1:
        await showSelectedCircleDialogBox(context, "You Tapped Blue Color");
        break;
      case 2:
        await showSelectedCircleDialogBox(context, "You Tapped Green Color");
        break;
      case 3:
        await showSelectedCircleDialogBox(context, "You Tapped Yellow Color");
        break;
      default:
        await showCanvasTappedDialogBox(context, "Tapped on canvas");
        break;
    }
  }
}

class CirclePainter extends CustomPainter {
  final List<Map<Rect, Paint>> rects;

  CirclePainter({@required this.rects});

  @override
  void paint(Canvas canvas, Size size) {
    drawCircles(canvas);
  }

  void drawCircles(Canvas canvas) {
    for (var rectangle in rects) {
      rectangle.entries.forEach(
        (element) {
          canvas.drawCircle(element.key.center, element.key.shortestSide / 2, element.value);
        },
      );
    }
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CirclePainter oldDelegate) => false;
}
