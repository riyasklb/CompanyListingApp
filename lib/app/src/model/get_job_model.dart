import 'dart:convert';

List<GetJobModel> getJobModelFromJson(String str) => List<GetJobModel>.from(json.decode(str).map((x) => GetJobModel.fromJson(x)));

String getJobModelToJson(List<GetJobModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetJobModel {
  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;
  bool applied;

  GetJobModel({
    required this.albumId,
    required this.id,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    this.applied = false,
  });

  factory GetJobModel.fromJson(Map<String, dynamic> json) => GetJobModel(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
        applied: false,
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
        "applied": applied,
      };
}
