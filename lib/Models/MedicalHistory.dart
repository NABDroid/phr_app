
class MedicalHistory {
  int historyId, userId, titleId;
  bool isTrue, isActive;
  String? remarks;


  MedicalHistory({
    required this.historyId,
    required this.userId,
    required this.titleId,
    required this.isTrue,
    required this.remarks,
    required this.isActive,
  });


  Map<String, dynamic> toJson() {
    return {
      'historyId': historyId,
      'userId': userId,
      'titleId': titleId,
      'isTrue': isTrue,
      'isActive': isActive,
      'remarks': remarks,
    };
  }
}