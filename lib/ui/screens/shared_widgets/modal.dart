import 'package:flutter/material.dart';
import 'package:notes_flutter_app/ui/theming/theme_manager.dart';

class Modal extends StatelessWidget {
  static const double _kElevation = 3.0;
  static const double _kTitleFontSize = 18.0;
  static const BorderRadius _kBorderRadius =
      BorderRadius.all(Radius.circular(16.0));

  const Modal({
    Key? key,
    required this.title,
    this.titlePadding = const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 8.0),
    required this.content,
    this.contentPadding = const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 8.0),
    required this.actions,
    this.actionsPadding = const EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 16.0),
  }) : super(key: key);

  final String title;
  final EdgeInsetsGeometry titlePadding;
  final Widget content;
  final EdgeInsetsGeometry contentPadding;
  final List<Widget> actions;
  final EdgeInsetsGeometry actionsPadding;

  @override
  Widget build(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Material(
          elevation: _kElevation,
          color: theme.data.backgroundColor,
          borderRadius: _kBorderRadius,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTitle(context),
              _buildContent(),
              _buildActions(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    final theme = ThemeManager.of(context).currentTheme;

    return Padding(
      padding: titlePadding,
      child: Text(
        title,
        style: TextStyle(
          fontSize: _kTitleFontSize,
          fontWeight: FontWeight.w500,
          color: theme.primaryTextColor,
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: contentPadding,
      child: content,
    );
  }

  Widget _buildActions() {
    return Padding(
      padding: actionsPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions,
      ),
    );
  }
}
