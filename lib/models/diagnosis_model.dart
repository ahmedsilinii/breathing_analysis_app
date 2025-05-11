class DiagnosisModel {
  final String id;
  final String? medicalReport;
  final String audioRecording;
  final String uid;
  final DateTime diagnosedAt;
  final List<String> results;

  DiagnosisModel({
    required this.id,
    required this.uid,
    this.medicalReport,
    required this.audioRecording,
    required this.diagnosedAt,
    required this.results,
  });

  Map<String, dynamic> toMap() {
    return {
      'medicalReport': medicalReport,
      'audioRecording': audioRecording,
      'uid': uid,
      'diagnosedAt': diagnosedAt.toIso8601String(),
      'results': results,
    };
  }

  factory DiagnosisModel.fromJson(Map<String, dynamic> json) {
    return DiagnosisModel(
      id: json['id'] as String,
      uid: json['uid'] as String,
      medicalReport: json['medicalReport'] as String?,
      audioRecording: json['audioRecording'] as String,
      diagnosedAt: DateTime.parse(json['diagnosedAt'] as String),
      results: List<String>.from(json['results'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uid': uid,
      'medicalReport': medicalReport,
      'audioRecording': audioRecording,
      'diagnosedAt': diagnosedAt.toIso8601String(),
      'results': results,
    };
  }

  DiagnosisModel copyWith({
    String? id,
    String? uid,
    String? medicalReport,
    String? audioRecording,
    DateTime? diagnosedAt,
    List<String>? results,
  }) {
    return DiagnosisModel(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      medicalReport: medicalReport ?? this.medicalReport,
      audioRecording: audioRecording ?? this.audioRecording,
      diagnosedAt: diagnosedAt ?? this.diagnosedAt,
      results: results ?? this.results,
    );
  }

  @override
  String toString() {
    return 'DiagnosisModel(id: $id, medicalReport: $medicalReport, audioRecording: $audioRecording, uid: $uid, diagnosedAt: $diagnosedAt, results: $results)';
  }
}
