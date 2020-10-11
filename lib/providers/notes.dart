import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/util/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Notes with ChangeNotifier {
  static const storageKey = 'pk-notes';

  CollectionReference _fs = FirebaseFirestore.instance.collection('notes');

  List<Note> _notes;

  List<Note> get notes {
    return _notes.isEmpty ? null : [..._notes];
  }

  Future<void> initNotes() async {
    if (await hasConnection()) {
      await _fetchNotes();
    } else {
      await _loadLocalNotes();
    }
  }

  Future<void> _fetchNotes() async {
    try {
      QuerySnapshot querySnapshot = await _fs.get();
      List<Note> fetchedNotes = querySnapshot.docs
          .map((doc) => Note.fromDocumentSnapshot(doc))
          .toList();
      _notes = _reorderNotes(fetchedNotes);
      await _storeNotesLocally();
      print('[+] Notes fetched from Firebase, stored locally.');
      notifyListeners();
    } catch (e, s) {
      print(e);
      print(s);
    }
  }

  Future<void> _storeNotesLocally() async {
    final prefs = await SharedPreferences.getInstance();
    final serialized = json.encode(
      _notes.map((e) => e.toJSON()).toList()
    );
    prefs.setString(storageKey, serialized);
  }

  Future<void> _loadLocalNotes() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(storageKey)) return;
    final jsonList = json.decode(prefs.getString(storageKey)) as List<dynamic>;
    _notes = jsonList.map((e) => Note.fromJSON(e)).toList();
    print('[+] No internet connection, notes fetched from device storage.');
    notifyListeners();
  }

  List<Note> _reorderNotes(List<Note> raw) {
    List<Note> archived = [];
    List<Note> active = [];
    raw.forEach((n) => n.archived ? archived.add(n) : active.add(n));
    archived.sort((a, b) => -a.added.compareTo(b.added));
    active.sort((a, b) => -a.added.compareTo(b.added));
    return [...active, ...archived];
  }
}
