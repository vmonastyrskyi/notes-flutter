import 'package:flutter/material.dart';

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: null,
    );
  }
}
