import 'package:cybergarden_app/data/models/PointModel.dart';

class CollectorModel{

  final int id;
  final String name;
  final String photo;
  final String description;
  final PointModel point;
  final Map contact;
  final int visited_cnt;
  String adress;
  bool liked;
  DateTime? visited_at;
  bool? is_offline;



  CollectorModel.fromJson(Map json) :
      id = json['id'],
      name = json['name'],
      photo = json['photo'],
      description = json['description'],
      point = PointModel.fromJson({
        "lat" : json['lat'],
        "long": json['long']
      }),
      contact = json['contact'],
      visited_cnt = json['visited_count'],
      adress = json['adress'],
        is_offline = json["is_offline"],
      liked = json['liked'];



}