import 'package:flutter/material.dart';
import 'package:notes_flutter_app/ui/icons/app_icons.dart';
import 'package:notes_flutter_app/ui/screens/shared_widgets/appbar_icon_button.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';
import 'package:notes_flutter_app/ui/theming/theme_switcher.dart';
import 'package:notes_flutter_app/view_models/notes/notes_viewmodel.dart';
import 'package:provider/provider.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  final UniqueKey _lightThemeButtonKey = UniqueKey();
  final UniqueKey _darkThemeButtonKey = UniqueKey();
  final UniqueKey _blockViewButtonKey = UniqueKey();
  final UniqueKey _listViewButtonKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _buildTitle(),
      ),
      actions: <Widget>[
        _buildThemeSwitcher(),
        _buildNotesViewChangeButton(),
      ],
    );
  }

  Widget _buildTitle() {
    final theme = ThemeManager.of(context).currentTheme;

    return Text(
      'Notes',
      style: TextStyle(color: theme.appBarForegroundColor),
    );
  }

  Widget _buildThemeSwitcher() {
    final theme = ThemeManager.of(context).currentTheme;

    return ThemeSwitcher(
      builder: (context) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: (child, animation) {
            final scale =
                Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            return ScaleTransition(
              scale: scale,
              child: child,
            );
          },
          child: theme.brightness == Brightness.light
              ? AppBarIconButton(
                  key: _darkThemeButtonKey,
                  onTap: () => ThemeSwitcher.of(context).toggleBrightness(),
                  icon: AppIcons.darkTheme,
                  iconSize: 24.0,
                  iconColor: theme.appBarForegroundColor,
                )
              : AppBarIconButton(
                  key: _lightThemeButtonKey,
                  onTap: () => ThemeSwitcher.of(context).toggleBrightness(),
                  icon: AppIcons.lightTheme,
                  iconSize: 24.0,
                  iconColor: theme.appBarForegroundColor,
                ),
        );
      },
    );
  }

  Widget _buildNotesViewChangeButton() {
    final theme = ThemeManager.of(context).currentTheme;

    return Selector<NotesViewModel, NotesView>(
      selector: (_, model) => model.notesView,
      builder: (_, notesView, __) {
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 350),
          reverseDuration: const Duration(milliseconds: 350),
          switchInCurve: Curves.easeInOutCubic,
          switchOutCurve: Curves.easeInOutCubic,
          transitionBuilder: (child, animation) {
            final scale =
                Tween<double>(begin: 0.0, end: 1.0).animate(animation);
            return ScaleTransition(
              scale: scale,
              child: child,
            );
          },
          child: notesView == NotesView.Block
              ? AppBarIconButton(
                  key: _listViewButtonKey,
                  onTap: () => context.read<NotesViewModel>().changeNotesView(),
                  icon: Icons.view_agenda,
                  iconSize: 24.0,
                  iconColor: theme.appBarForegroundColor,
                )
              : AppBarIconButton(
                  key: _blockViewButtonKey,
                  onTap: () => context.read<NotesViewModel>().changeNotesView(),
                  icon: Icons.dashboard,
                  iconSize: 24.0,
                  iconColor: theme.appBarForegroundColor,
                ),
        );
      },
    );
  }
}
