import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/view_models/base_viewmodel.dart';

enum NotesView {
  List,
  Block,
}

class NotesViewModel extends BaseViewModel {
  // List<Note> _notes = const [];

  List<Note> _notes = [
    Note(title: 'Title', content: '1111', createdAt: '12:34'),
    Note(title: 'Title', content: '22222222', createdAt: '12:34'),
    Note(title: 'Title', content: '333\333\n333333', createdAt: '12:34'),
    Note(title: 'Title', content: '44444444444444\n44', createdAt: '12:34'),
    Note(title: 'Title', content: '5555', createdAt: '12:34'),
    Note(title: 'Title', content: '6\n6\n6\n6\n6\n6', createdAt: '12:34'),
    Note(title: 'Title', content: '77\n7777\n777\n7', createdAt: '12:34'),
    Note(title: 'Title', content: '8', createdAt: '12:34'),
  ];
  NotesView _notesView = NotesView.Block;
  Map<Note, int> _deletedNotes = {};

  List<Note> get notes => _notes;

  NotesView get notesView => _notesView;

  void removeNote(Note note) {
    if (_notes.contains(note)) {
      _deletedNotes[note] = _notes.indexOf(note);
      _notes.remove(note);
      notifyListeners();
    }
  }

  void changeNotesView() {
    _notesView =
        _notesView == NotesView.Block ? NotesView.List : NotesView.Block;
    notifyListeners();
  }

  void undoNoteDeletion(Note note) {
    if (_deletedNotes.isNotEmpty) {
      _notes.insert(_deletedNotes[note]!, note);
      notifyListeners();
    }
  }
}
