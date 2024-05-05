import 'dart:convert';

class ScUser {
  // Personal information
  String id;
  String email;
  String name;
  String pwd;
  String phone;
  String deviceToken;
  String role;
  String rating;
  bool isAdmin;

  // Time-related
  String joinTime;

  // Additional properties
  String city;
  String institute;
  String subject;// teacher
  String className; // student

  // Constructor with initial values
  ScUser({
    this.id = '',
    this.email = '',
    this.name = '',
    this.pwd = '',
    this.rating = '',
    this.phone = '',
    this.role = '',
    this.deviceToken = '',
    this.isAdmin = false,
    this.joinTime = '',
    this.city = '',
    this.institute = '',
    this.subject = '',
    this.className = '',
  });

  // Convert ScUser object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'rating': rating,
      'name': name,
      'role': role,
      'pwd': pwd,
      'deviceToken': deviceToken,
      'phone': phone,
      'isAdmin': isAdmin,
      'joinTime': joinTime,
      'city': city,
      'institute': institute,
      'subject': subject,
      'className': className,
    };
  }

  // Create ScUser object from JSON
  factory ScUser.fromJson(Map<String, dynamic> json) {
    return ScUser(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      role: json['role'] ?? '',
      email: json['email'] ?? '',
      rating: json['rating'] ?? '',
      pwd: json['pwd'] ?? '',
      deviceToken: json['deviceToken'] ?? '',
      phone: json['phone'] ?? '',
      isAdmin: json['isAdmin'] ?? false,
      joinTime: json['joinTime'] ?? '',
      city: json['city'] ?? '',
      institute: json['institute'] ?? '',
      subject: json['subject'] ?? '',
      className: json['className'] ?? '',
    );
  }
}
