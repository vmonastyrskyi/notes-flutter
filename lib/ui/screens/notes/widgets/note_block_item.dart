import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:notes_flutter_app/ui/screens/edit_note/edit_note_screen.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';
import 'package:notes_flutter_app/ui/util/date_util.dart';
import 'package:notes_flutter_app/ui/util/slide_page_route.dart';
import 'package:notes_flutter_app/view_models/edit_note/edit_note_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/note_viewmodel.dart';
import 'package:provider/provider.dart';

class NoteBlockItem extends StatelessWidget {
  const NoteBlockItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Material(
      color: theme.noteItemBackgroundColor,
      shadowColor: Colors.black26,
      elevation: 7.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            SlidePageRoute(
              builder: (_) => MultiProvider(
                providers: [
                  ChangeNotifierProvider<NoteViewModel>.value(
                    value: context.read<NoteViewModel>(),
                  ),
                  ChangeNotifierProxyProvider<NoteViewModel, EditNoteViewModel>(
                    create: (_) => EditNoteViewModel(),
                    update: (_, noteViewModel, editNoteViewModel) =>
                        editNoteViewModel!..update(noteViewModel),
                  ),
                ],
                child: EditNoteScreen(),
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTitle(context),
              _buildText(context),
              _buildCreatedAt(context)
            ],
          ),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(16.0)),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Selector<NoteViewModel, String>(
      selector: (_, model) => model.title,
      builder: (_, title, __) {
        if (title.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                  color: theme.noteItemTitleColor,
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildText(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Selector<NoteViewModel, String>(
      selector: (_, model) => model.text,
      builder: (_, text, __) {
        if (text.isNotEmpty) {
          return Text(
            text,
            maxLines: 4,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: theme.noteItemTextColor,
            ),
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  Widget _buildCreatedAt(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Selector<NoteViewModel, bool>(
      selector: (_, model) => model.showDate,
      builder: (_, showDate, __) {
        if (showDate) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: Selector<NoteViewModel, String>(
                  selector: (_, model) => formatDate(model.createdAt),
                  builder: (_, createdAt, __) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4.0,
                        horizontal: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: theme.data.backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                      ),
                      child: Text(
                        createdAt,
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: theme.noteItemCreatedAtColor,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
