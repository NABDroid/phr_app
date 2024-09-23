class HistoryTitle {
  final int titleId;
  final String title;
  bool isChecked;

  HistoryTitle({
    required this.titleId,
    required this.title,
    required this.isChecked,
  });

  factory HistoryTitle.fromJson(Map<String, dynamic> json) {
    return HistoryTitle(
      titleId: json['titleId'],
      title: json['title'],
      isChecked: json['isActive'],
    );
  }
}
