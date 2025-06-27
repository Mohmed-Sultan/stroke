import 'package:flutter/material.dart';

// patient_appointment_filteration_provider.dart
import 'package:flutter/foundation.dart';

class PatientAppointmentFilterationProvider with ChangeNotifier {
  final Map<String, String?> _filters = {
    'status': null,
    'timeFrame': null,
  };

  String? getFilter(String key) => _filters[key];

  Map<String, String?> get allFilters => Map.from(_filters);

  bool get hasActiveFilters =>
      _filters.values.any((value) => value != null);

  void applyFilters(Map<String, String?> newFilters) {
    _filters.clear();
    _filters.addAll(newFilters);
    notifyListeners();
  }

  void setFilter(String key, String? value) {
    _filters[key] = value;
    notifyListeners();
  }

  void clearFilter(String key) {
    _filters[key] = null;
    notifyListeners();
  }

  void clearAllFilters() {
    _filters.clear();
    notifyListeners();
  }
}