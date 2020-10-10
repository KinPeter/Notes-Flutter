import 'package:notes/models/link.dart';

class Note {
  String id;
  DateTime added;
  bool archived;
  List<Link> links;
  String text;
}