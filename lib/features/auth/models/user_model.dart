import 'dart:convert';

//doctor model
class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String profileImg;
  final String role;
  final String gender;
  final DateTime dateOfBirth;
  final String phone;
  final String country;
  final String address;
  final int? appointmentFee; // Add this field

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImg,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.country,
    required this.address,
    this.appointmentFee,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      profileImg: json['profileImg'],
      role: json['role'],
      gender: json['gender'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      phone: json['phone'],
      country: json['country'],
      address: json['address'],
      appointmentFee: json['appointmentFee'], // Add this
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'profileImg': profileImg,
    'role': role,
    'gender': gender,
    'dateOfBirth': dateOfBirth.toIso8601String(),
    'phone': phone,
    'country': country,
    'address': address,
    'appointmentFee': appointmentFee, // Add this
  };
}



// patient model
class Patient {
  String id;
  String firstName;
  String lastName;
  String email;
  String profileImg;
  String role;
  String gender;
  DateTime dateOfBirth;
  String phone;
  String country;
  String address;
  String t;
  List<String> favoriteDoctors;
  DateTime createdAt;
  int v;

  Patient({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImg,
    required this.role,
    required this.gender,
    required this.dateOfBirth,
    required this.phone,
    required this.country,
    required this.address,
    required this.t,
    required this.favoriteDoctors,
    required this.createdAt,
    required this.v,
  });

  factory Patient.fromRawJson(String str) => Patient.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    profileImg: json["profileImg"],
    role: json["role"],
    gender: json["gender"],
    dateOfBirth: DateTime.parse(json["dateOfBirth"]),
    phone: json["phone"],
    country: json["country"],
    address: json["address"],
    t: json["__t"],
    favoriteDoctors: List<String>.from(json["favoriteDoctors"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "profileImg": profileImg,
    "role": role,
    "gender": gender,
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "phone": phone,
    "country": country,
    "address": address,
    "__t": t,
    "favoriteDoctors": List<dynamic>.from(favoriteDoctors.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "__v": v,
  };
}
