// appointment_model.dart
import 'dart:convert';

class Appointment {
  final String id;
  final String status;
  final DateTime startTime;
  final DateTime endTime;
  final Doctor doctor;
  final InlinePatient patient;
  final Payment payment;

  Appointment({
    required this.id,
    required this.status,
    required this.startTime,
    required this.endTime,
    required this.doctor,
    required this.patient,
    required this.payment,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['_id'],
      status: json['status'],
      startTime: DateTime.parse(json['startTime']),
      endTime: DateTime.parse(json['endTime']),
      doctor: Doctor.fromJson(json['doctor']),
      patient: InlinePatient.fromJson(json['patient']),
      payment: Payment.fromJson(json['payment']),
    );
  }
}

class Doctor {
  final String id;
  final String firstName;
  final String lastName;
  final String profileImg;
  final int appointmentFee;

  Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImg,
    required this.appointmentFee,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      profileImg: json['profileImg'],
      appointmentFee: json['appointmentFee'],
    );
  }
}

class InlinePatient {
  final String id;
  final String firstName;
  final String lastName;

  InlinePatient({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory InlinePatient.fromJson(Map<String, dynamic> json) {
    return InlinePatient(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Payment {
  String status;
  String? stripeSessionId;

  Payment({
    required this.status,
    this.stripeSessionId,
  });

  factory Payment.fromRawJson(String str) => Payment.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    status: json["status"],
    stripeSessionId: json["stripeSessionId"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "stripeSessionId": stripeSessionId,
  };
}