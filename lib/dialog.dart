import 'package:flutter/material.dart';

Future<void> showSelectedCircleDialogBox(BuildContext context, String text) async {
  await showDialog(
    context: context,
    builder: (context) => DialogBox(text: text),
  );
}

Future<void> showCanvasTappedDialogBox(BuildContext context, String text) async {
  await showDialog(
    context: context,
    builder: (context) => DialogBox(text: text),
  );
}

class DialogBox extends StatelessWidget {
  const DialogBox({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          Text(text),
        ],
      ),
    );
  }
}
