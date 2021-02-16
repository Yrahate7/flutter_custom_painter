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
        painter: CirclePainter(listOfRectsAndPaint: rectsAndPaint),
        size: MediaQuery.of(context).size,
      ),
    );
  }

  void onCircleTap(TapDownDetails details, BuildContext context) async {
    RenderBox box = context.findRenderObject();

    // Find the offset at where the tap has occured in the given context's renderbox
    final offset = box.globalToLocal(details.globalPosition);

    // Find index where the rectangle contains the offset at which the tap event occured
    final index = rectsAndPaint.lastIndexWhere(
      (rect) => checkIfRectangleContainsOffset(rect, offset),
    );

    await showColorNameDialogIfIndexFoundOrShowTappedCanvasDialog(context, index);
  }

  bool checkIfRectangleContainsOffset(Map<Rect, Paint> rectangleWithPaint, Offset tapLocationOffset) {
    // Since we have a Map with only one entry, Use the first rectangle
    Rect rect = rectangleWithPaint.entries.first.key;

    print((rect.center - tapLocationOffset).distance);

    // From the drawn rectangle's center check if the tapLocation's Offset's distance
    // is less than the half of rectangle's shortest side
    // If Yes, It means the tap occured on the given rectangle
    // If no , it means the tap occured on the canvas
    if ((rect.center - tapLocationOffset).distance < rect.shortestSide / 2) {
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
  final List<Map<Rect, Paint>> listOfRectsAndPaint;

  CirclePainter({@required this.listOfRectsAndPaint});

  @override
  void paint(Canvas canvas, Size size) {
    drawCircles(canvas);
  }

  void drawCircles(Canvas canvas) {
    for (var rectangleAndPaint in listOfRectsAndPaint) {
      rectangleAndPaint.entries.forEach(
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
