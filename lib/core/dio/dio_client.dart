import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/auth/models/user_model.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();
  late Dio dio;
  late CookieJar cookieJar;

  factory DioClient() {
    return _instance;
  }

  DioClient._internal() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://neuroguard-api.onrender.com',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ));

    initCookieManager();
  }
  Future<void> initCookieManager() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    cookieJar = PersistCookieJar(
      storage: FileStorage("${appDocDir.path}/.cookies/"),
    );
    dio.interceptors.add(CookieManager(cookieJar));
  }

  Future<void> saveCookies(Response response) async {
    await cookieJar.saveFromResponse(
      response.requestOptions.uri,
      response.headers['set-cookie']!
          .map((str) => Cookie.fromSetCookieValue(str))
          .toList(),
    );
  }

  Future<void> clearCookies() async {
    await cookieJar.deleteAll();
  }
  Future<Map<String, dynamic>> getOnePatients({
    required String  id,

  }) async {
    try {
      final response = await dio.get(
        '/api/v1/patients/$id',
      );

      return  response.data;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Failed to fetch patients';
    }
  }
  Future<Map<String, dynamic>> getPatients({
    String? gender,
    int? page,
    int? limit,
    String? sort, //= 'firstName',
    String? fields, // = 'firstName,lastName,email',
  }) async {
    try {
      final response = await dio.get(
        '/api/v1/patients',
        queryParameters: {
          if (gender != null) 'gender': gender,
         if(page!=null) 'page': page,
          if(limit!=null)  'limit': limit,
          if(sort!=null)  'sort': sort,
          if(fields!=null)  'fields': fields,
        },
      );

      return  response.data;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Failed to fetch patients';
    }
  }
  // Add this new method for fetching appointments
  Future<Map<String, dynamic>> getAppointments({
    String? status,
    String? timeFrame,
    String? searchQuery,
    bool? completed,
    int? page,
    int? limit,
    String? sort,
    String? fields,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {
        if (status != null) 'status': status,
        if (timeFrame != null) 'timeFrame': timeFrame,
        if (searchQuery != null && searchQuery.isNotEmpty) 'search': searchQuery,
        if (completed != null) 'completed': completed.toString(),
        if (page != null) 'page': page,
        if (limit != null) 'limit': limit,
        if (sort != null) 'sort': sort,
        if (fields != null) 'fields': fields,
      };

      final response = await dio.get(
        '/api/v1/appointments',
        queryParameters: queryParams,
      );

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Failed to fetch appointments';
    }
  }
}

class DoctorService {
  final DioClient dioClient;

  DoctorService(this.dioClient);

  Future<void> uploadDocument(File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData formData = FormData.fromMap({
        "files": await MultipartFile.fromFile(file.path, filename: fileName),
      });

      final response = await dioClient.dio.post(
        '/api/v1/doctors/upload',
        data: formData,
      );

      if (response.statusCode != 200) {
        throw response.data?['message'] ?? 'Document upload failed';
      }

      // Handle successful upload response here
      print('Upload successful: ${response.data}');
    } on DioException catch (e) {
      throw e.response?.data?['message'] ??
          'Document upload failed: ${e.message}';
    }
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await dioClient.dio.patch(
        '/api/v1/doctors/profile',
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode != 200) {
        throw response.data?['message'] ?? 'Profile update failed';
      }

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ??
          'Profile update failed: ${e.message}';
    }
  }

  Future<void> deleteProfile() async {
    try {
      final response = await dioClient.dio.delete(
        '/api/v1/doctors/profile',
      );

      if (response.statusCode != 200) {
        throw response.data?['message'] ?? 'Profile deletion failed';
      }

      return response.data;
    } on DioException catch (e) {
      throw e.response?.data?['message'] ??
          'Profile deletion failed: ${e.message}';
    }
  }

  Future<User> uploadProfileImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(imageFile.path),
      });

      final response = await dioClient.dio.post(
        '/api/v1/doctors/profile/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        // تحليل الاستجابة للحصول على بيانات المستخدم المحدثة
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return User.fromJson(responseData['data']);
        } else {
          throw responseData['message'] ?? 'Image upload failed';
        }
      } else {
        throw 'Image upload failed with status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Image upload failed: ${e.message}';
    }
  }

  Future<User> updateProfileInfo(Map<String, dynamic> data) async {
    try {
      final response = await dioClient.dio.patch(
        '/api/v1/doctors/profile',
        data: data,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'Content-Type': 'application/json'},
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData['status'] == 'success') {
          return User.fromJson(responseData['data']);
        } else {
          throw responseData['message'] ?? 'Profile update failed';
        }
      } else {
        throw 'Profile update failed with status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      throw e.response?.data?['message'] ??
          'Profile update failed: ${e.message}';
    }
  }

  Future<User> updateAppointmentFee(int fee) async {
    return await updateProfileInfo({'appointmentFee': fee});
  }
}
