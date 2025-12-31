import 'package:flutter/foundation.dart';
import '../services/api_service.dart';
import 'enrollment.dart';

class EnrollmentProvider with ChangeNotifier {
  List<Enrollment> _enrollments = [];
  bool _isLoading = false;
  String? _error;

  List<Enrollment> get enrollments => _enrollments;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchMyEnrollments(int studentId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/students/$studentId/enrollments');

      if (response['success'] == true) {
        final data = response['data'];
        _enrollments = (data['items'] as List)
            .map((json) => Enrollment.fromJson(json))
            .toList();
      }
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Không thể tải danh sách khóa học';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> enrollCourse(int courseId) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      final response = await apiService.post('/enrollments', body: {
        'course_id': courseId,
      });
      _isLoading = false;
      notifyListeners();
      return response['success'] == true;
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> dropEnrollment(int enrollmentId) async {
    try {
      final response = await apiService.delete('/enrollments/$enrollmentId');
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }
}
