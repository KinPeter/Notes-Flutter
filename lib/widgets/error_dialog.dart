import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String message;
  final BuildContext ctx;

  ErrorDialog(this.ctx, this.message);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ooops!'),
      content: Text(message),
      actions: [
        FlatButton(
          child: Text('OK'),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    );
  }
}
