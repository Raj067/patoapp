class NotificationModel {
  final int? id;
  final String title;
  final String description;
  final String dateEvent;
  final String startTime;
  final String endTime;
  final bool isCompleted;

  const NotificationModel({
    this.id,
    required this.title,
    required this.description,
    required this.dateEvent,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
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
    return 'NotificationModel{id: $id, title: $title, dateEvent: $dateEvent}';
  }
}
