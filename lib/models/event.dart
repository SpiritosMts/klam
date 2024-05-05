class Meeting {
  String title;
  String id;
  String objective;
  String desc;
  String imageUrl;
  String date;

  Meeting({
    this.id = '',
    this.title = '',
    this.objective = '',
    this.desc = '',
    this.imageUrl = '',
    this.date = '',
  });

  // Add the toJson method to the Event class
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'objective': objective,
      'desc': desc,
      'imageUrl': imageUrl,
      'date': date,
    };
  }

  // Create Event object from JSON
  factory Meeting.fromJson(Map<String, dynamic> json) {
    return Meeting(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      objective: json['objective'] ?? '',
      desc: json['desc'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      date: json['date'] ?? '',
    );
  }
}
