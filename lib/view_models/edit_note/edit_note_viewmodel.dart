import 'package:flutter/material.dart';
import 'package:notes_flutter_app/view_models/base_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/note_viewmodel.dart';

class EditNoteViewModel extends BaseViewModel {
  EditNoteViewModel({
    bool createMode = false,
  }) : _createMode = createMode;

  final TextEditingController titleInputController = TextEditingController();
  final TextEditingController textInputController = TextEditingController();

  late NoteViewModel _noteViewModel;
  late bool _showDate;

  bool _createMode;

  bool get showDate => _showDate;

  set showDate(bool showDate) {
    _showDate = showDate;
    notifyListeners();
  }

  bool get createMode => _createMode;

  void update(NoteViewModel noteViewModel) {
    _noteViewModel = noteViewModel;

    titleInputController.text = _noteViewModel.title;
    textInputController.text = _noteViewModel.text;
    _showDate = _noteViewModel.showDate;

    titleInputController.selection = TextSelection.fromPosition(
        TextPosition(offset: titleInputController.text.length));
    textInputController.selection = TextSelection.fromPosition(
        TextPosition(offset: textInputController.text.length));
  }

  bool hasChanges() {
    return (_noteViewModel.title != titleInputController.text) ||
        (_noteViewModel.text != textInputController.text) ||
        (_noteViewModel.showDate != _showDate);
  }

  bool isValid() {
    return titleInputController.text.isNotEmpty ||
        textInputController.text.isNotEmpty;
  }

  void saveChanges() {
    _noteViewModel.title = titleInputController.text;
    _noteViewModel.text = textInputController.text;
    _noteViewModel.showDate = _showDate;
  }
}
