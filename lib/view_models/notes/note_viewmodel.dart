import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/view_models/base_viewmodel.dart';

class NoteViewModel extends BaseViewModel {
  NoteViewModel({
    required Note note,
  })   : _title = note.title,
        _text = note.text,
        _createdAt = note.createdAt,
        _showDate = note.showDate;

  String _title;
  String _text;
  DateTime _createdAt;
  bool _showDate;

  String get title => _title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String get text => _text;

  set text(String text) {
    _text = text;
    notifyListeners();
  }

  DateTime get createdAt => _createdAt;

  set createdAt(DateTime date) {
    _createdAt = date;
    notifyListeners();
  }

  bool get showDate => _showDate;

  set showDate(bool showDate) {
    _showDate = showDate;
    notifyListeners();
  }
}
