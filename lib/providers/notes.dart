import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

class Notes with ChangeNotifier {
  CollectionReference _fs = FirebaseFirestore.instance.collection('notes');

  List<Note> _notes;

  List<Note> get notes {
    return _notes.isEmpty ? null : [..._notes];
  }

  Future<void> fetchNotes() async {
    try {
      QuerySnapshot querySnapshot = await _fs.get();
      querySnapshot.docs.forEach((doc) {
        print(doc.data());
        print(doc.id);
        print(doc.data()['added']);
        print((doc.data()['added'] as Timestamp).toDate());
        // back: Timestamp.fromDate(DateTime date)
      });
    } catch (e) {

    }
  }
}