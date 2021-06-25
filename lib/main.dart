import 'package:flutter/material.dart';
import 'package:notes_flutter_app/ui/screens/notes/notes_screen.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';
import 'package:notes_flutter_app/ui/theming/theme_provider.dart';
import 'package:notes_flutter_app/view_models/notes/notes_viewmodel.dart';
import 'package:provider/provider.dart';

void main() => runApp(NotesApp());

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: ThemeManager(
        builder: (_, theme) {
          return MaterialApp(
            title: 'Notes',
            theme: theme,
            home: ChangeNotifierProvider(
              create: (_) => NotesViewModel(),
              child: NotesScreen(),
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
