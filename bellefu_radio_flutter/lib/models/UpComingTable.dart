// ignore_for_file: non_constant_identifier_names

import 'package:bellefu/common/Constants.dart';

class UpComingTable {
  final int id;
  final String image_url;
  final String title;
  final String description;
  final String scheduled_for;
  final String scheduled_to;
  final String status;
  final String replay_file;

  UpComingTable({
    required this.id,
    required this.image_url,
    required this.title,
    required this.description,
    required this.scheduled_for,
    required this.scheduled_to,
    required this.status,
    required this.replay_file,
  });

  factory UpComingTable.fromJson(Map<String, dynamic> json) {
    return UpComingTable(
      id: json['id'],
      image_url: Constants.SERVER_STORAGE_URL + json['image_url'],
      title: json['title'],
      description: json['description'],
      scheduled_for: json['scheduled_for'],
      scheduled_to: json['scheduled_to'],
      status: json['status'],
      replay_file: Constants.SERVER_STORAGE_URL + json['replay_file'].toString(),
    );
  }
}

class Adverts {
  final int id;
  final String image_url;
  final String caption;

  Adverts({required this.id, required this.image_url, required this.caption});

  factory Adverts.fromJson(Map<String, dynamic> json) {
    return Adverts(
      id: json['id'],
      image_url: Constants.SERVER_STORAGE_URL + '/adverts/' + json['image_url'],
      caption: json['caption'],
    );
  }
}
