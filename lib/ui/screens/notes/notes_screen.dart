import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_flutter_app/ui/screens/notes/widgets/note_block_item.dart';
import 'package:notes_flutter_app/ui/screens/notes/widgets/note_list_item.dart';
import 'package:notes_flutter_app/ui/theming/theme_switcher_area.dart';
import 'package:notes_flutter_app/view_models/notes/notes_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_app_bar.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  final UniqueKey _listNotesKey = UniqueKey();
  final UniqueKey _blockNotesKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        body: Selector<NotesViewModel, NotesView>(
          selector: (_, model) => model.notesView,
          builder: (_, notesView, __) {
            return AnimatedSwitcher(
              duration: Duration(milliseconds: 350),
              reverseDuration: Duration(milliseconds: 350),
              switchInCurve: Curves.easeInOutCubic,
              switchOutCurve: Curves.easeInOutCubic,
              transitionBuilder: (child, animation) {
                final opacity =
                    Tween<double>(begin: 0.0, end: 1.0).animate(animation);
                return FadeTransition(
                  opacity: opacity,
                  child: child,
                );
              },
              child: notesView == NotesView.Block
                  ? _buildNotesAsBlock()
                  : _buildNotesAsList(),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
          elevation: 6.0,
        ),
      ),
    );
  }

  Widget _buildNotesAsList() {
    return Consumer<NotesViewModel>(
      key: _listNotesKey,
      builder: (_, model, __) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          physics: const BouncingScrollPhysics(),
          itemCount: model.notes.length,
          itemBuilder: (_, index) => Dismissible(
            key: ObjectKey(model.notes[index]),
            confirmDismiss: (direction) async {
              final snackBar = ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 5),
                  content: Row(
                    children: [
                      CircularCountDownTimer(
                        duration: 5,
                        controller: CountDownController(),
                        width: 32,
                        height: 32,
                        ringColor: Colors.grey[300]!,
                        fillColor: Color.fromARGB(255, 57, 162, 219),
                        backgroundColor: Colors.transparent,
                        strokeWidth: 3.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: true,
                        onStart: () {
                          print('Countdown Started');
                        },
                        onComplete: () {
                          print('Countdown Ended');
                        },
                      ),
                      const SizedBox(width: 16),
                      Text('Note deleted'),
                    ],
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {},
                  ),
                ),
              );
              final snackBarResult = await snackBar.closed;
              if (snackBarResult == SnackBarClosedReason.action) {
                return false;
              } else {
                return true;
              }
            },
            onDismissed: (direction) {
              print('$index dismissed');
            },
            child: NoteListItem(note: model.notes[index]),
          ),
          separatorBuilder: (_, __) => const SizedBox(height: 16.0),
        );
      },
    );
  }

  Widget _buildNotesAsBlock() {
    return Consumer<NotesViewModel>(
      key: _blockNotesKey,
      builder: (_, model, __) {
        return StaggeredGridView.countBuilder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const BouncingScrollPhysics(),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          crossAxisCount: 2,
          itemCount: model.notes.length,
          itemBuilder: (_, index) => Dismissible(
            key: ObjectKey(model.notes[index]),
            direction: index.isOdd
                ? DismissDirection.startToEnd
                : DismissDirection.endToStart,
            confirmDismiss: (direction) async {
              final snackBar = ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 5),
                  content: Row(
                    children: [
                      CircularCountDownTimer(
                        duration: 5,
                        controller: CountDownController(),
                        width: 32,
                        height: 32,
                        ringColor: Colors.grey[300]!,
                        fillColor: Color.fromARGB(255, 57, 162, 219),
                        backgroundColor: Colors.transparent,
                        strokeWidth: 3.0,
                        strokeCap: StrokeCap.round,
                        textStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                        ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        isReverseAnimation: true,
                      ),
                      const SizedBox(width: 16),
                      Text('Note deleted'),
                    ],
                  ),
                  action: SnackBarAction(
                    label: 'UNDO',
                    onPressed: () {},
                  ),
                ),
              );
              final snackBarResult = await snackBar.closed;
              if (snackBarResult == SnackBarClosedReason.action) {
                return false;
              } else {
                context.read<NotesViewModel>().removeNote(model.notes[index]);
                return true;
              }
            },
            onDismissed: (direction) {
              print('$index dismissed');
            },
            child: NoteBlockItem(note: model.notes[index]),
          ),
          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
        );
      },
    );
  }
}
