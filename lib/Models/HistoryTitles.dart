class HistoryTitle {
  final int titleId;
  final String title;
  final bool isChecked;

  HistoryTitle({
    required this.titleId,
    required this.title,
    this.isChecked,
  });

  // Factory method to create a HistoryTitle object from JSON
  factory HistoryTitle.fromJson(Map<String, dynamic> json) {
    return HistoryTitle(
      titleId: json['titleId'],
      title: json['title'],
      isChecked: json['isActive'],
    );
  }
}
