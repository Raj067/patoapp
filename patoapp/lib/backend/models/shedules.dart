class SheduleModel {
  final int id;
  final String title;
  final String description;
  final String dateEvent;
  final String startTime;
  final String endTime;
  final int isCompleted;
  final int color;
  final String repeat;
  final String createdAt;
  final int remind;

  SheduleModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dateEvent,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
    required this.color,
    required this.repeat,
    required this.remind,
    this.createdAt = '2022-08-01',
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateEvent': dateEvent,
      'startTime': startTime,
      'endTime': endTime,
      'color': color,
      'repeat': repeat,
      'remind': remind,
      'createdAt': createdAt,
      'isCompleted': isCompleted,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'SheduleModel{id: $id, title: $title, dateEvent: $dateEvent}';
  }
}

SheduleModel fromJsonShedule(Map<String, dynamic> e) {
  return SheduleModel(
    id: e['id'],
    dateEvent: e['dateEvent'],
    endTime: e['endTime'],
    startTime: e['startTime'],
    title: e['title'],
    description: e['description'],
    isCompleted: e['isCompleted'] ?? 0,
    color: e['color'],
    repeat: e['repeat'],
    remind: e['remind'],
    createdAt: e['createdAt'],
  );
}
