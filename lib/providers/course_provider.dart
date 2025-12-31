import 'package:flutter/foundation.dart';
import '../models/models.dart';
import '../services/api_service.dart';

class CourseProvider with ChangeNotifier {
  List<Course> _courses = [];
  Course? _selectedCourse;
  bool _isLoading = false;
  String? _error;
  int _totalItems = 0;
  int _currentPage = 1;

  List<Course> get courses => _courses;
  Course? get selectedCourse => _selectedCourse;
  bool get isLoading => _isLoading;
  String? get error => _error;
  int get totalItems => _totalItems;
  int get currentPage => _currentPage;

  Future<void> fetchCourses({
    int page = 1,
    int limit = 10,
    String? search,
    String? category,
    String? level,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final queryParams = {
        'page': page.toString(),
        'limit': limit.toString(),
        'published_only': 'true',
        if (search != null && search.isNotEmpty) 'search': search,
        if (category != null && category.isNotEmpty) 'category': category,
        if (level != null && level.isNotEmpty) 'level': level,
      };

      final response = await apiService.get('/courses', queryParams: queryParams);

      if (response['success'] == true) {
        final data = response['data'];
        _courses = (data['items'] as List)
            .map((json) => Course.fromJson(json))
            .toList();
        _totalItems = data['totalItems'];
        _currentPage = page;
      }
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Không thể tải danh sách khóa học';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchCourseById(int id) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final response = await apiService.get('/courses/$id');

      if (response['success'] == true) {
        _selectedCourse = Course.fromJson(response['data']);
      }
    } on ApiException catch (e) {
      _error = e.message;
    } catch (e) {
      _error = 'Không thể tải thông tin khóa học';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearSelectedCourse() {
    _selectedCourse = null;
    notifyListeners();
  }
}
