import 'package:flutter/material.dart';
import 'package:notes/material_theme.dart';
import 'package:notes/providers/auth.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/screens/edit_note.dart';
import 'package:notes/screens/notes_main.dart';
import 'package:provider/provider.dart';

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Auth()),
        ChangeNotifierProvider(create: (ctx) => Notes()),
      ],
      child: MaterialApp(
        title: 'Notes',
        theme: notesTheme,
        home: Scaffold(
          appBar: AppBar(
            title: Text('Notes'),
          ),
          body: Center(
            child: Text('Notes'),
          ),
        ),
        routes: {
          NotesMainScreen.routeName: (ctx) => NotesMainScreen(),
          EditNoteScreen.routeName: (ctx) => EditNoteScreen(),
        },
      ),
    );
  }
}