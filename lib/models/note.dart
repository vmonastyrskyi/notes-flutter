class Note {
  Note({
    required this.title,
    required this.text,
    required this.createdAt,
    this.showDate = true,
  });

  Note.create({
    required String title,
    required String text,
    required bool showDate,
  }) : this(
            title: title,
            text: text,
            createdAt: DateTime.now(),
            showDate: showDate);

  Note.empty() : this(title: '', text: '', createdAt: DateTime.now());

  final String title;
  final String text;
  final DateTime createdAt;
  bool showDate;
}
