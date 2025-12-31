class Lesson {
  final int id;
  final int courseId;
  final String title;
  final String? description;
  final String? videoUrl;
  final int duration;
  final int order;
  final String createdAt;

  Lesson({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    this.videoUrl,
    required this.duration,
    required this.order,
    required this.createdAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      courseId: json['course_id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['video_url'],
      duration: json['duration'] ?? 0,
      order: json['order'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  String get durationDisplay {
    if (duration < 60) {
      return '$duration phút';
    }
    final hours = duration ~/ 60;
    final mins = duration % 60;
    return mins > 0 ? '${hours}h ${mins}m' : '${hours}h';
  }
}
