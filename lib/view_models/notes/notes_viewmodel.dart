import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/view_models/base_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/note_viewmodel.dart';

enum NotesView {
  List,
  Block,
}

class NotesViewModel extends BaseViewModel {
  NotesViewModel() {
    _sortNotesByDate();
  }

  List<NoteViewModel> _notes = [
    NoteViewModel(
      note: Note(
          title: 'Notes Application',
          text: 'Made by Vladyslav Monastyrskyi',
          createdAt: DateTime.parse('2021-06-27 20:00')),
    ),
    NoteViewModel(
      note: Note(
          title: 'Features',
          text: '+ Нелинейные анимации;\n'
              '+ Возможность переключить тему;\n'
              '+ Заметки в виде блоков и списка;\n'
              '+ Редактирование и сохранение изменний;\n'
              '+ Функционал создания новой заметки;\n'
              '- Нет сохранения при выходе.',
          createdAt: DateTime.parse('2021-06-25 19:00'),
          showDate: false),
    ),
    NoteViewModel(
      note: Note(
          title: 'Repository',
          text: 'https://github.com/monastyrskyi?tab=repositories',
          createdAt: DateTime.parse('2021-06-23 18:00')),
    ),
  ];

  NotesView _notesView = NotesView.Block;

  List<NoteViewModel> get notes => _notes;

  NotesView get notesView => _notesView;

  void addNote(Note note) {
    _notes.add(NoteViewModel(note: note));
    _sortNotesByDate();
    notifyListeners();
  }

  void deleteNote(NoteViewModel noteViewModel) {
    if (_notes.contains(noteViewModel)) {
      _notes.remove(noteViewModel);
      notifyListeners();
    }
  }

  void undoNoteDeletion(NoteViewModel noteViewModel) {
    _notes.add(noteViewModel);
    notifyListeners();
  }

  void changeNotesView() {
    _notesView =
        _notesView == NotesView.Block ? NotesView.List : NotesView.Block;
    notifyListeners();
  }

  void _sortNotesByDate() {
    _notes.sort((a, b) {
      return b.createdAt.millisecondsSinceEpoch
          .compareTo(a.createdAt.millisecondsSinceEpoch);
    });
  }
}
