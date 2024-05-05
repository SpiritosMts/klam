import 'dart:convert';

class FileCard {
  // Properties
  String name;
  String subject;
  String imageUrl;
  String teacher;
  String size;
  String id;
  String time;
  String targetClass;
  int downloads;
  double rating;
  int raters;
  String fileFormat;

  // Constructor with initial values
  FileCard({
    this.name = '',
    this.subject = '',
    this.imageUrl = '',
    this.size = '',
    this.teacher = '',
    this.id = '',
    this.time = '',
    this.targetClass = '',
    this.downloads = 0,
    this.rating = 0.0,
    this.raters = 0,
    this.fileFormat = '',
  });

  // Convert FileCard object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subject': subject,
      'size': size,
      'imageUrl': imageUrl,
      'teacher': teacher,
      'id': id,
      'time': time,
      'targetClass': targetClass,
      'downloads': downloads,
      'rating': rating,
      'raters': raters,
      'fileFormat': fileFormat,
    };
  }

  // Create FileCard object from JSON
  factory FileCard.fromJson(Map<String, dynamic> json) {
    return FileCard(
      name: json['name'] ?? '',
      subject: json['subject'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      teacher: json['teacher'] ?? '',
      size: json['size'] ?? '',
      id: json['id'] ?? '',
      time: json['time'] ?? '',
      targetClass: json['targetClass'] ?? '',
      downloads: json['downloads'] ?? 0,
      rating: (json['rating'] ?? 0.0).toDouble(),
      raters: json['raters'] ?? 0,
      fileFormat: json['fileFormat'] ?? '',
    );
  }
}
