import 'package:flutter/material.dart';
import 'package:notes/providers/auth.dart';
import 'package:notes/providers/connection.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/screens/edit_note.dart';
import 'package:notes/widgets/app_drawer.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:notes/widgets/notes_list.dart';
import 'package:provider/provider.dart';

class NotesMainScreen extends StatefulWidget {
  static const routeName = '/notes';

  @override
  _NotesMainScreenState createState() => _NotesMainScreenState();
}

class _NotesMainScreenState extends State<NotesMainScreen> {
  bool _isLoading = true;

  void _setLoading(bool value) {
    setState(() {
      _isLoading = value;
    });
  }

  void _onError(e) {
    showDialog(
      context: context,
      builder: (ctx) => ErrorDialog(ctx, 'Could not load your notes.'),
    );
  }

  @override
  void initState() {
    _setLoading(true);
    Provider.of<Notes>(context, listen: false)
        .initNotes()
        .then((_) {})
        .catchError(_onError)
        .whenComplete(() => _setLoading(false));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final connection = Provider.of<Connection>(context);
    final auth = Provider.of<Auth>(context);

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text('Notes'),
          actions: [
            if (!connection.isConnected) Icon(Icons.wifi_off),
            if (auth.isAuth)
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).pushNamed(EditNoteScreen.routeName);
                  }),
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : NotesList(),
        drawer: AppDrawer(),
        floatingActionButton: !auth.isAuth || _isLoading
            ? Container()
            : FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditNoteScreen.routeName);
                },
              ));
  }
}
