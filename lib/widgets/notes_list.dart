import 'package:flutter/material.dart';
import 'package:notes/providers/connection.dart';
import 'package:notes/providers/notes.dart';
import 'package:notes/widgets/note_card_wrapper.dart';
import 'package:notes/widgets/nothing_here.dart';
import 'package:provider/provider.dart';

class NotesList extends StatelessWidget {
  Future<void> _refreshNotes(BuildContext context) async {
    await Provider.of<Notes>(context, listen: false).initNotes();
    await Provider.of<Connection>(context, listen: false).checkConnection();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Notes>(context);

    return RefreshIndicator(
      onRefresh: () => _refreshNotes(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: provider.notes != null && provider.notes.length > 0
            ? ListView.builder(
                itemCount: provider.notes.length,
                itemBuilder: (ctx, i) => NoteCardWrapper(provider.notes[i]),
              )
            : NothingHere(),
      ),
    );
  }
}
