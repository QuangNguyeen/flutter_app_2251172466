import '../models/course.dart';
import '../models/student.dart';

class Enrollment {
  final int id;
  final int studentId;
  final int courseId;
  final String enrollmentDate;
  final int progress;
  final String status;
  final bool certificateIssued;
  final String? lastAccessedAt;
  final Course? course;
  final Student? student;

  Enrollment({
    required this.id,
    required this.studentId,
    required this.courseId,
    required this.enrollmentDate,
    required this.progress,
    required this.status,
    required this.certificateIssued,
    this.lastAccessedAt,
    this.course,
    this.student,
  });

  factory Enrollment.fromJson(Map<String, dynamic> json) {
    return Enrollment(
      id: json['id'],
      studentId: json['student_id'],
      courseId: json['course_id'],
      enrollmentDate: json['enrollment_date'] ?? '',
      progress: json['progress'] ?? 0,
      status: json['status'] ?? 'active',
      certificateIssued: json['certificate_issued'] ?? false,
      lastAccessedAt: json['last_accessed_at'],
      course: json['course'] != null ? Course.fromJson(json['course']) : null,
      student: json['student'] != null ? Student.fromJson(json['student']) : null,
    );
  }

  String get statusDisplay {
    switch (status) {
      case 'active':
        return 'Đang học';
      case 'completed':
        return 'Hoàn thành';
      case 'dropped':
        return 'Đã hủy';
      default:
        return status;
    }
  }

  bool get isActive => status == 'active';
  bool get isCompleted => status == 'completed';
}
