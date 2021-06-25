import 'package:flutter/material.dart';
import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';

class NoteBlockItem extends StatelessWidget {
  const NoteBlockItem({Key? key, required this.note}) : super(key: key);

  final Note note;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.noteItemBackgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 3.5),
            blurRadius: 7.0,
          ),
        ],
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildTitle(context),
          const SizedBox(height: 8),
          _buildContent(context),
          const SizedBox(height: 16),
          _buildCreatedAt(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Text(
      note.title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: theme.noteItemTitleColor,
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Text(
      note.content,
      maxLines: 4,
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      style: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: theme.noteItemContentColor,
      ),
    );
  }

  Widget _buildCreatedAt(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Text(
      note.createdAt,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: theme.noteItemCreatedAtColor,
      ),
    );
  }
}
