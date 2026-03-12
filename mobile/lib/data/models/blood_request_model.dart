class BloodRequest {
  final int id;
  final String hospital;
  final String group;
  final String urgency; // 'critical' | 'moderate' | 'low'
  final String distance;
  final String description;
  final String? status;
  final String date;

  BloodRequest({
    required this.id,
    required this.hospital,
    required this.group,
    required this.urgency,
    required this.distance,
    required this.description,
    this.status,
    required this.date,
  });

  factory BloodRequest.fromMock(Map<String, dynamic> map) {
    return BloodRequest(
      id: map['id'],
      hospital: map['hospital'],
      group: map['group'],
      urgency: map['urgency'],
      distance: map['distance'],
      description: map['description'],
      status: map['status'],
      date: map['date'] ?? 'À l\'instant',
    );
  }
}
