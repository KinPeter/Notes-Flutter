import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/providers/auth.dart';
import 'package:notes/providers/connection.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/widgets/error_dialog.dart';
import 'package:notes/widgets/note_card.dart';
import 'package:provider/provider.dart';

class NoteCardWrapper extends StatelessWidget {
  final Note note;

  NoteCardWrapper(this.note);

  Future<bool> confirmDismiss(
      DismissDirection direction, BuildContext context) {
    if (direction == DismissDirection.endToStart) {
      final Future<bool> result = showDialog<bool>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text('Do you want to delete this note?'),
          actions: [
            FlatButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(ctx).pop(false);
              },
            ),
            FlatButton(
              textColor: Theme.of(context).errorColor,
              child: Text('YES'),
              onPressed: () {
                Navigator.of(ctx).pop(true);
              },
            ),
          ],
        ),
      );
      return result;
    }
    return Future.value(true);
  }

  Future<void> onDismissed(
      DismissDirection direction, BuildContext context) async {
    final isDelete = direction == DismissDirection.endToStart;
    try {
      if (isDelete) {
        Provider.of<Notes>(context, listen: false).deleteNote(note.id);
      } else {
        Provider.of<Notes>(context, listen: false).archiveNote(note.id);
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => ErrorDialog(
            ctx,
            isDelete
                ? 'Unable to delete note.'
                : 'Unable to change archived status.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<Notes>(context);
    final auth = Provider.of<Auth>(context);
    final connection = Provider.of<Connection>(context);

    return auth.isAuth && connection.isConnected
        ? Dismissible(
            key: ValueKey(note.id),
            direction: DismissDirection.horizontal,
            confirmDismiss: (direction) => confirmDismiss(direction, context),
            onDismissed: (direction) => onDismissed(direction, context),
            background: Container(
              // To right
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              color: Colors.grey.shade400,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      note.archived ? Icons.unarchive : Icons.archive,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              // To left
              margin:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              color: Theme.of(context).errorColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ],
              ),
            ),
            child: NoteCard(note),
          )
        : NoteCard(note);
  }
}
