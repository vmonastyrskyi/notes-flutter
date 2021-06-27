import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/ui/screens/edit_note/edit_note_screen.dart';
import 'package:notes_flutter_app/ui/screens/notes/widgets/note_block_item.dart';
import 'package:notes_flutter_app/ui/theming/theme_switcher_area.dart';
import 'package:notes_flutter_app/ui/util/slide_page_route.dart';
import 'package:notes_flutter_app/view_models/edit_note/edit_note_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/note_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/notes_viewmodel.dart';
import 'package:provider/provider.dart';

import 'widgets/custom_app_bar.dart';
import 'widgets/note_list_item.dart';

class NotesScreen extends StatelessWidget {
  NotesScreen({Key? key}) : super(key: key);

  final UniqueKey _listNotesKey = UniqueKey();
  final UniqueKey _blockNotesKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcherArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: CustomAppBar(),
        ),
        body: Selector<NotesViewModel, NotesView>(
          selector: (_, model) => model.notesView,
          builder: (_, notesView, __) {
            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 375),
              reverseDuration: const Duration(milliseconds: 375),
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
                  ? _buildNotesAsBlock(context)
                  : _buildNotesAsList(context),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final note = await Navigator.of(context).push<Note>(
              SlidePageRoute(
                builder: (_) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider<NoteViewModel>(
                      create: (_) => NoteViewModel(note: Note.empty()),
                    ),
                    ChangeNotifierProxyProvider<NoteViewModel,
                        EditNoteViewModel>(
                      create: (_) => EditNoteViewModel(createMode: true),
                      update: (_, noteViewModel, editNoteViewModel) =>
                          editNoteViewModel!..update(noteViewModel),
                    ),
                  ],
                  child: EditNoteScreen(),
                ),
              ),
            );
            if (note != null) {
              context.read<NotesViewModel>().addNote(note);
            }
          },
          elevation: 3.5,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildNotesAsList(BuildContext context) {
    final notesViewModel = context.read<NotesViewModel>();

    return Consumer<NotesViewModel>(
      key: _listNotesKey,
      builder: (_, model, __) {
        return ListView.separated(
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          physics: const BouncingScrollPhysics(),
          itemCount: model.notes.length,
          itemBuilder: (_, index) {
            final noteViewModel = model.notes[index];

            return Slidable(
              key: ObjectKey(noteViewModel),
              actionPane: const SlidableScrollActionPane(),
              actionExtentRatio: 0.0,
              child: ChangeNotifierProvider.value(
                value: noteViewModel,
                child: NoteListItem(),
              ),
              dismissal: SlidableDismissal(
                child: const SlideWithFadeDismissal(),
                dismissThresholds: {
                  SlideActionType.primary: 0.6,
                  SlideActionType.secondary: 0.6,
                },
                onWillDismiss: (_) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    _deletedNoteSnackBar(context, noteViewModel),
                  );
                  return true;
                },
                onDismissed: (_) {
                  notesViewModel.deleteNote(noteViewModel);
                },
              ),
              actions: <Widget>[
                const SizedBox.shrink(),
              ],
              secondaryActions: <Widget>[
                const SizedBox.shrink(),
              ],
            );
          },
          separatorBuilder: (_, __) => const SizedBox(height: 16.0),
        );
      },
    );
  }

  Widget _buildNotesAsBlock(BuildContext context) {
    final notesViewModel = context.read<NotesViewModel>();

    return Consumer<NotesViewModel>(
      key: _blockNotesKey,
      builder: (_, model, __) {
        return StaggeredGridView.countBuilder(
          staggeredTileBuilder: (_) => const StaggeredTile.fit(1),
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          physics: const BouncingScrollPhysics(),
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          crossAxisCount: 2,
          itemCount: model.notes.length,
          itemBuilder: (_, index) {
            final noteViewModel = model.notes[index];

            return Slidable(
              key: ObjectKey(noteViewModel),
              actionPane: const SlidableScrollActionPane(),
              actionExtentRatio: 0.0,
              child: ChangeNotifierProvider.value(
                value: noteViewModel,
                child: NoteBlockItem(),
              ),
              dismissal: SlidableDismissal(
                child: const SlideWithFadeDismissal(),
                dismissThresholds: {
                  SlideActionType.primary: 0.6,
                  SlideActionType.secondary: 0.6,
                },
                onWillDismiss: (_) async {
                  ScaffoldMessenger.of(context).showSnackBar(
                    _deletedNoteSnackBar(context, noteViewModel),
                  );
                  return true;
                },
                onDismissed: (_) {
                  notesViewModel.deleteNote(noteViewModel);
                },
              ),
              actions: <Widget>[
                const SizedBox.shrink(),
              ],
              secondaryActions: <Widget>[
                const SizedBox.shrink(),
              ],
            );
          },
        );
      },
    );
  }

  SnackBar _deletedNoteSnackBar(
      BuildContext context, NoteViewModel noteViewModel) {
    return SnackBar(
      duration: const Duration(seconds: 5),
      content: Row(
        children: <Widget>[
          CircularCountDownTimer(
            duration: 5,
            controller: CountDownController(),
            width: 24.0,
            height: 24.0,
            ringColor: Colors.transparent,
            fillColor: Colors.white,
            strokeWidth: 2.0,
            textStyle: const TextStyle(
              fontSize: 15.0,
            ),
            textFormat: CountdownTextFormat.S,
            isReverse: true,
            isReverseAnimation: true,
          ),
          const SizedBox(width: 16.0),
          const Text(
            'Note deleted',
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ],
      ),
      action: SnackBarAction(
        label: 'UNDO',
        textColor: Color.fromARGB(255, 57, 162, 219),
        onPressed: () {
          context.read<NotesViewModel>().undoNoteDeletion(noteViewModel);
        },
      ),
    );
  }
}

class SlideWithFadeDismissal extends StatelessWidget {
  const SlideWithFadeDismissal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SlidableData data = SlidableData.of(context)!;

    final opacity = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(data.overallMoveAnimation);

    final position = Tween<Offset>(
      begin: Offset.zero,
      end: data.createOffset(data.actionSign),
    ).animate(data.overallMoveAnimation);

    return SlideTransition(
      position: position,
      child: FadeTransition(
        opacity: opacity,
        child: data.slidable.child,
      ),
    );
  }
}
