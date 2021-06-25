import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/view_models/base_viewmodel.dart';

enum NotesView {
  List,
  Block,
}

class NotesViewModel extends BaseViewModel {
  // List<Note> _notes = const [];

  List<Note> _notes = [
    Note(title: 'Title', content: '123', createdAt: '12:34'),
    Note(title: 'Title', content: '321321', createdAt: '12:34'),
    Note(title: 'Title', content: '111\n111\n111111', createdAt: '12:34'),
    Note(title: 'Title', content: '222222222222\n22', createdAt: '12:34'),
    Note(title: 'Title', content: '33333', createdAt: '12:34'),
    Note(title: 'Title', content: '4\n4\n4\n4\n4\n4', createdAt: '12:34'),
    Note(title: 'Title', content: '55\n5555\n555\n5', createdAt: '12:34'),
    Note(title: 'Title', content: '6666', createdAt: '12:34'),
  ];
  NotesView _notesView = NotesView.Block;

  List<Note> get notes => _notes;

  NotesView get notesView => _notesView;

  void removeNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void changeNotesView() {
    _notesView =
        _notesView == NotesView.Block ? NotesView.List : NotesView.Block;
    notifyListeners();
  }
}
