class VideoModel {
  String title;
  String videoUrl;
  String thumbnail;
  String remainingTime;

  VideoModel({
    required this.title,
    required this.videoUrl,
    required this.thumbnail,
    required this.remainingTime,
  });

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      remainingTime: json['remainingTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'videoUrl': videoUrl,
      'thumbnail': thumbnail,
      'remainingTime': remainingTime,
    };
  }
}
