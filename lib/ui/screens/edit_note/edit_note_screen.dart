import 'package:flutter/material.dart';
import 'package:notes_flutter_app/models/note.dart';
import 'package:notes_flutter_app/ui/screens/shared_widgets/appbar_icon_button.dart';
import 'package:notes_flutter_app/ui/screens/shared_widgets/modal.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';
import 'package:notes_flutter_app/view_models/edit_note/edit_note_viewmodel.dart';
import 'package:notes_flutter_app/view_models/notes/note_viewmodel.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen>
    with TickerProviderStateMixin {
  late final AnimationController _fabAnimationController;
  late final Animation<Offset> _fabPosition;

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _fabPosition = Tween<Offset>(
      begin: const Offset(0.0, 1.5),
      end: const Offset(0.0, 0.0),
    ).animate(
      CurvedAnimation(
        parent: _fabAnimationController,
        curve: Curves.easeInOutBack,
      ),
    );
  }

  @override
  void dispose() {
    _fabAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;
    final model = context.read<EditNoteViewModel>();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: AppBarIconButton(
          onTap: () {
            if (model.hasChanges()) {
              _showAlert();
            } else if (model.createMode && model.isValid()) {
              final note = Note.create(
                title: model.titleInputController.text,
                text: model.textInputController.text,
                showDate: model.showDate,
              );
              Navigator.of(context).pop(note);
            } else {
              Navigator.of(context).pop();
            }
          },
          icon: Icons.arrow_back,
          iconColor: theme.appBarForegroundColor,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            _buildTitleInput(),
            const SizedBox(height: 8.0),
            _buildTextInput(),
            const SizedBox(height: 8.0),
            _buildShowDateCheckbox(),
          ],
        ),
      ),
      floatingActionButton: SlideTransition(
        position: _fabPosition,
        child: FloatingActionButton(
          onPressed: () {
            model.saveChanges();
            _fabAnimationController.reverse();
          },
          elevation: 3.5,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Widget _buildTitleInput() {
    final theme = ThemeManager.of(context).currentTheme;
    final model = context.read<EditNoteViewModel>();

    return Material(
      color: theme.noteItemBackgroundColor,
      shadowColor: Colors.black26,
      elevation: 7.0,
      child: TextField(
        controller: model.titleInputController,
        onChanged: (_) {
          model.hasChanges()
              ? _fabAnimationController.forward()
              : _fabAnimationController.reverse();
        },
        maxLines: 1,
        autofocus: true,
        autocorrect: true,
        cursorColor: theme.accentColor,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        style: TextStyle(
          color: theme.noteItemTitleColor,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16.0),
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(
            color: theme.editNoteHintTitleColor,
            fontSize: 16.0,
          ),
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    );
  }

  Widget _buildTextInput() {
    final theme = ThemeManager.of(context).currentTheme;
    final model = context.read<EditNoteViewModel>();

    return Material(
      color: theme.noteItemBackgroundColor,
      shadowColor: Colors.black26,
      elevation: 7.0,
      child: AnimatedSize(
        curve: Curves.easeInOutCubic,
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.topCenter,
        vsync: this,
        child: TextField(
          controller: model.textInputController,
          onChanged: (_) {
            model.hasChanges()
                ? _fabAnimationController.forward()
                : _fabAnimationController.reverse();
          },
          minLines: 4,
          maxLines: 999,
          autofocus: false,
          autocorrect: true,
          cursorColor: theme.accentColor,
          textInputAction: TextInputAction.newline,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.multiline,
          style: TextStyle(
            color: theme.noteItemTextColor,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16.0),
            border: InputBorder.none,
            hintText: 'Text',
            hintStyle: TextStyle(
              color: theme.editNoteHintTextColor,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
    );
  }

  Widget _buildShowDateCheckbox() {
    final theme = ThemeManager.of(context).currentTheme;
    final model = context.read<EditNoteViewModel>();
    final showDate =
        context.select<EditNoteViewModel, bool>((model) => model.showDate);

    Color checkboxFillColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.selected,
      };
      if (states.any(interactiveStates.contains)) {
        return theme.accentColor;
      }
      return theme.primaryTextColor;
    }

    return Row(
      children: <Widget>[
        Transform.scale(
          scale: 1.25,
          child: Checkbox(
            checkColor: Colors.white,
            fillColor: MaterialStateProperty.resolveWith(checkboxFillColor),
            value: showDate,
            splashRadius: 18.0,
            onChanged: (bool? checked) {
              if (checked != null) {
                model.showDate = checked;
                model.hasChanges()
                    ? _fabAnimationController.forward()
                    : _fabAnimationController.reverse();
              }
            },
          ),
        ),
        Text(
          'Show date',
          style: TextStyle(
            color: theme.primaryTextColor,
            fontSize: 15.0,
          ),
        ),
      ],
    );
  }

  Future<void> _showAlert() async {
    final theme = ThemeManager.of(context).currentTheme;
    final model = context.read<EditNoteViewModel>();

    return showGeneralDialog<void>(
      context: context,
      barrierLabel: '',
      barrierColor: Colors.black54,
      barrierDismissible: true,
      transitionBuilder: (_, animation, __, child) {
        final scale = animation.drive(Tween<double>(begin: 0.5, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)));
        final opacity = animation.drive(Tween<double>(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeInOutCubic)));
        return ScaleTransition(
          scale: scale,
          child: FadeTransition(
            opacity: opacity,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, _, __) {
        return Modal(
          title: 'Warning',
          content: Text(
            'You have unsaved changes',
            style: TextStyle(
              fontSize: 15.0,
              color: theme.primaryTextColor,
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              color: theme.accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Save and exit',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                if (model.createMode && model.isValid()) {
                  final note = Note.create(
                    title: model.titleInputController.text,
                    text: model.textInputController.text,
                    showDate: model.showDate,
                  );
                  Navigator.of(context).pop();
                  Navigator.of(context).pop(note);
                } else {
                  model.saveChanges();
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                }
              },
            ),
            MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                'Exit without saving',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: theme.primaryTextColor,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
