import 'package:flutter/material.dart';
import 'package:notes/providers/notes.dart';
import 'package:provider/provider.dart';

class NotesMainScreen extends StatefulWidget {
  static const routeName = '/notes';

  @override
  _NotesMainScreenState createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  @override
  void initState() {
    Provider.of<Notes>(context, listen: false).fetchNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Center(
        child: Text('Notes'),
      ),
    );
  }
}
