class SheduleModel {
  final int? id;
  final String title;
  final String description;
  final String dateEvent;
  final String startTime;
  final String endTime;
  final int isCompleted;

  const SheduleModel({
    this.id,
    required this.title,
    required this.description,
    required this.dateEvent,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateEvent': dateEvent,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'SheduleModel{id: $id, title: $title, dateEvent: $dateEvent}';
  }
}
