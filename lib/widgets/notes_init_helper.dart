import 'package:flutter/material.dart';

class NotesInitHelper extends StatelessWidget {
  final String message;

  NotesInitHelper(this.message);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Notes'),
        ),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }
}