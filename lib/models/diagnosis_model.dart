class DiagnosisModel {
  final String id;
  final String? medicalReportLink;
  final String audioRecordingLink;
  final String uid;
  final DateTime diagnosedAt;
  final List<String> results;

  DiagnosisModel({
    required this.id,
    required this.uid,
    this.medicalReportLink,
    required this.audioRecordingLink,
    required this.diagnosedAt,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicalReportLink': medicalReportLink,
      'audioRecordingLink': audioRecordingLink,
      'uid': uid,
      'diagnosedAt': diagnosedAt.toIso8601String(),
      'results': results,
    };
  }

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      medicalReportLink: json['medicalReportLink'] as String?,
      audioRecordingLink: json['audioRecordingLink'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
      results: List<String>.from(json['results'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'medicalReportLink': medicalReportLink,
      'audioRecordingLink': audioRecordingLink,
      'diagnosedAt': diagnosedAt.toIso8601String(),
      'results': results,
    };
  }

  DiagnosisModel copyWith({
    String? id,
    String? uid,
    String? medicalReportLink,
    String? audioRecordingLink,
    DateTime? diagnosedAt,
    List<String>? results,
  }) {
    return DiagnosisModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      medicalReportLink: medicalReportLink ?? this.medicalReportLink,
      audioRecordingLink: audioRecordingLink ?? this.audioRecordingLink,
      diagnosedAt: diagnosedAt ?? this.diagnosedAt,
      results: results ?? this.results,
    );
  }

  @override
  String toString() {
    return 'DiagnosisModel(id: $id, medicalReportLink: $medicalReportLink, audioRecordingLink: $audioRecordingLink, uid: $uid, diagnosedAt: $diagnosedAt, results: $results)';
  }
}
