class Activity {
  final String clientName;
  final String type;
  final String notes;
  final DateTime date;

  Activity({
    required this.clientName,
    required this.type,
    required this.notes,
    required this.date,
  });

  Map<String, dynamic> toMap() => {
    'clientName': clientName,
    'type': type,
    'notes': notes,
    'date': date.toIso8601String(),
  };
} 