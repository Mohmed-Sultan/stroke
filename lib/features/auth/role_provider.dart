import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/dio/dio_client.dart';
import 'models/user_model.dart';

class RoleProvider with ChangeNotifier {
  String? _role;
  User? _user;
  final DioClient dioClient  ;
  late DoctorService doctorService;
  String? get role => _role;
  User? get user => _user;
  RoleProvider(this.dioClient) {
    doctorService = DoctorService(dioClient);
  }
  Future<void> setRole(String role) async {
    _role = role;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('role', role);
    notifyListeners();
  }

  Future<void> loginSuccess(User userData, Response response) async {
    _user = userData;
    _role = userData.role;

    // Save cookies
    await dioClient.saveCookies(response);

    // Save user data
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(userData.toJson()));
    await prefs.setString('role', userData.role);

    notifyListeners();
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getString('role');
    final userJson = prefs.getString('user');

    if (role != null) _role = role;
    if (userJson != null) {
      _user = User.fromJson(json.decode(userJson));
    }

    // Initialize cookies - will be auto-sent by DioClient
    await dioClient.initCookieManager();

    notifyListeners();
  }




  Future<void> uploadDocument(File file) async {
    try {
      await doctorService.uploadDocument(file);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateAppointmentFee(int fee) async {
    try {
      await doctorService.updateAppointmentFee(fee);

      // Update local user data
      if (_user != null) {
        _user = User(
          id: _user!.id,
          firstName: _user!.firstName,
          lastName: _user!.lastName,
          email: _user!.email,
          profileImg: _user!.profileImg,
          role: _user!.role,
          gender: _user!.gender,
          dateOfBirth: _user!.dateOfBirth,
          phone: _user!.phone,
          country: _user!.country,
          address: _user!.address,
          appointmentFee: fee,
        );
        await _saveUserToPrefs();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateUserProfile(User newUser) async {
    try {
      // إرسال البيانات المحدثة إلى الخادم
      final updatedUser = await doctorService.updateProfileInfo({
        "firstName": newUser.firstName,
        "lastName": newUser.lastName,
        "phone": newUser.phone,
        "country": newUser.country,
        "address": newUser.address,
      });

      // تحديث البيانات المحلية
      _user = updatedUser;
      await _saveUserToPrefs();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _saveUserToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (_user != null) {
      await prefs.setString('user', json.encode(_user!.toJson()));
    }
  }


  Future<void> deleteProfile(BuildContext context) async {
    try {
      await doctorService.deleteProfile();
      await logout(context);
    } catch (e) {
      rethrow;
    }
  }



  Future<void> logout(BuildContext context) async {
    try {
      await dioClient.clearCookies();

      // Clear local data
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('role');
      await prefs.remove('user');

      _role = null;
      _user = null;
      notifyListeners();
      if(Navigator.canPop(context)){Navigator.pop(context);}
      // Navigate to login screen
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/login',
            (Route<dynamic> route) => false,
      );
    } catch (e) {
      print("Logout error: $e");
    }
  }
  Future<void> updateProfileImage(File imageFile) async {
    try {
      final updatedUser = await doctorService.uploadProfileImage(imageFile);

      // تحديث بيانات المستخدم المحلية
      _user = updatedUser;
      await _saveUserToPrefs();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<String> uploadProfileImage(File imageFile) async {
    try {
      String fileName = imageFile.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(imageFile.path, filename: fileName),
      });

      final response = await dioClient.dio.post(
        '/api/v1/doctors/upload',
        data: formData,
      );

      if (response.statusCode == 200) {
        // تحليل الرد للحصول على رابط الصورة الجديدة
        return response.data['imageUrl'] ?? response.data['url'];
      } else {
        throw response.data?['message'] ?? 'Image upload failed';
      }
    } on DioException catch (e) {
      throw e.response?.data?['message'] ?? 'Image upload failed: ${e.message}';
    }
  }
}