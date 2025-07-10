import 'dart:convert';

class AdvertModel {
  int id;
  String image_url; // c - 100
  String caption; // c - 20
  String show_from; // datetime
  String show_ends; // datetime
  String blog; // - text
  String link_url; // - c - 255

  AdvertModel({
    required this.id,
    required this.image_url,
    required this.caption,
    required this.show_from,
    required this.show_ends,
    required this.blog,
    required this.link_url,
  });

  factory AdvertModel.fromJson(Map<String, dynamic> map) => AdvertModel(
        id: map['id']?.toInt() ?? 0,
        image_url: map['image_url'] ?? '',
        caption: map['caption'] ?? '',
        show_from: map['show_from'] ?? '',
        show_ends: map['show_ends'] ?? '',
        blog: map['blog'] ?? '',
        link_url: map['link_url'] ?? '',
      );
}
