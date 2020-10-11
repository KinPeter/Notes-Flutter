import 'package:flutter/material.dart';

class EditNoteScreen extends StatefulWidget {
  static const routeName = '/edit-note';

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  @override
  Widget build(BuildContext context) {
    final noteId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(noteId != null ? 'Edit Note' : 'Add New Note'),
      ),
      body: Center(
        child: Text('Edit note'),
      ),
    );
  }
}
