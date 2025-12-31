import 'lesson.dart';

class Course {
  final int id;
  final String title;
  final String? description;
  final String instructor;
  final String category;
  final String level;
  final int duration;
  final double price;
  final String? imageUrl;
  final double rating;
  final int studentCount;
  final int lessonCount;
  final bool isPublished;
  final String createdAt;
  final List<Lesson>? lessons;

  Course({
    required this.id,
    required this.title,
    this.description,
    required this.instructor,
    required this.category,
    required this.level,
    required this.duration,
    required this.price,
    this.imageUrl,
    required this.rating,
    required this.studentCount,
    required this.lessonCount,
    required this.isPublished,
    required this.createdAt,
    this.lessons,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      instructor: json['instructor'],
      category: json['category'],
      level: json['level'],
      duration: json['duration'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
      imageUrl: json['image_url'],
      rating: (json['rating'] ?? 0).toDouble(),
      studentCount: json['student_count'] ?? 0,
      lessonCount: json['lesson_count'] ?? 0,
      isPublished: json['is_published'] ?? false,
      createdAt: json['created_at'] ?? '',
      lessons: json['lessons'] != null
          ? (json['lessons'] as List).map((l) => Lesson.fromJson(l)).toList()
          : null,
    );
  }

  String get formattedPrice {
    return '${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (match) => '${match[1]}.',
        )} VND';
  }

  String get categoryDisplay {
    switch (category) {
      case 'Programming':
        return 'Lập trình';
      case 'Design':
        return 'Thiết kế';
      case 'Business':
        return 'Kinh doanh';
      case 'Language':
        return 'Ngôn ngữ';
      case 'Music':
        return 'Âm nhạc';
      default:
        return category;
    }
  }

  String get levelDisplay {
    switch (level) {
      case 'Beginner':
        return 'Cơ bản';
      case 'Intermediate':
        return 'Trung cấp';
      case 'Advanced':
        return 'Nâng cao';
      default:
        return level;
    }
  }
}
