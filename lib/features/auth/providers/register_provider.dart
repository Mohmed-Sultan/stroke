import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

class RegistrationProvider with ChangeNotifier {
  final Dio _dio = Dio();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String dateOfBirth,
    required String gender,
    required String phone,
    required String country,
    required String address,
    required String specialization,
    required int appointmentFee,
  }) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _dio.post(
        'https://neuroguard-api.onrender.com/api/v1/doctors/register',
        data: json.encode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
          "dateOfBirth": dateOfBirth,
          "gender": gender,
          "phone": phone,
          "country": country,
          "address": address,
          "specilization": specialization,
          "appointmentFee": appointmentFee,
          "defaultWorkingDays": false,
          "workingDays": [
            {"day": 0},
            {"day": 1, "start": "14:00", "end": "16:00"},
            {"day": 2, "start": "10:00", "end": "22:00"},
            {"day": 3},
            {"day": 4, "start": "10:00", "end": "12:00"}
          ]
        }),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _errorMessage = null;
      } else {
        _errorMessage = "Registration failed: ${response.statusCode}";
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        _errorMessage = "Email already exists";
      } else {
        _errorMessage = e.response?.data?['message'] ?? "Registration failed. Please try again.";
      }
    } catch (e) {
      _errorMessage = "Unexpected error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}