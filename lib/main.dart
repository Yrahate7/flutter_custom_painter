import 'package:flutter/material.dart';
import './shapes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WhiteCanvas(),
    );
  }
}

class WhiteCanvas extends StatefulWidget {
  WhiteCanvas({Key key}) : super(key: key);

  @override
  _WhiteCanvasState createState() => _WhiteCanvasState();
}

class _WhiteCanvasState extends State<WhiteCanvas> {
  // ------------------------------------ UI ------------------------------------ //
  Paint red = Paint()..color = Colors.red;
  Paint blue = Paint()..color = Colors.blue;
  Paint green = Paint()..color = Colors.green;
  Paint yellow = Paint()..color = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: canvasUI());
  }

  Widget canvasUI() {
    return GestureDetector(
      // onTapDown: (details) async => onCanvasTapped(details, context),
      child: Container(
        color: Colors.cyan,
        child: Center(
          child: Circles(
            rectsAndPaint: [
              {Rect.fromLTWH(50, 200, 50, 50): red},
              {Rect.fromLTWH(300, 200, 50, 50): blue},
              {Rect.fromLTWH(50, 400, 50, 50): green},
              {Rect.fromLTWH(300, 400, 50, 50): yellow},
            ],
          ),
        ),
      ),
    );
  }

  // ------------------------- Event Handlers --------------------------- //

  Future<void> onCanvasTapped(TapDownDetails details, BuildContext context) async {
    // var xCoordinate = details.globalPosition.dx;
    // var yCoordinate = details.globalPosition.dy;

    // await showCanvasTappedDialogBox(context, "You have not Tapped on a circle");
  }
}

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MaterialApp(home: RectsExample()));
// }

// class RectsExample extends StatefulWidget {
//   @override
//   _RectsExampleState createState() => _RectsExampleState();
// }

// class _RectsExampleState extends State<RectsExample> {
//   int _index = -1;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Rects(
//           rects: [
//             Rect.fromLTRB(10, 20, 30, 40),
//             Rect.fromLTRB(40, 60, 80, 100),
//           ],
//           selectedIndex: _index,
//           onSelected: (index) {
//             setState(() {
//               _index = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// class Rects extends StatelessWidget {
//   final List<Rect> rects;
//   final void Function(int) onSelected;
//   final int selectedIndex;

//   const Rects({
//     Key key,
//     @required this.rects,
//     @required this.onSelected,
//     this.selectedIndex = -1,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (details) {
//         RenderBox box = context.findRenderObject();
//         final offset = box.globalToLocal(details.globalPosition);
//         final index = rects.lastIndexWhere((rect) => rect.contains(offset));
//         if (index != -1) {
//           onSelected(index);
//           return;
//         }
//         onSelected(-1);
//       },
//       child: CustomPaint(
//         size: Size(320, 240),
//         painter: _RectPainter(rects, selectedIndex),
//       ),
//     );
//   }
// }

// class _RectPainter extends CustomPainter {
//   static Paint _red = Paint()..color = Colors.red;
//   static Paint _blue = Paint()..color = Colors.blue;

//   final List<Rect> rects;
//   final int selectedIndex;

//   _RectPainter(this.rects, this.selectedIndex);

//   @override
//   void paint(Canvas canvas, Size size) {
//     var i = 0;
//     for (Rect rect in rects) {
//       canvas.drawRect(rect, i++ == selectedIndex ? _red : _blue);
//     }
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return true;
//   }
// }
