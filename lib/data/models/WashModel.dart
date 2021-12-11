import 'package:cybergarden_app/data/models/PointModel.dart';

class WashModel{

  final int id;
  final String name;
  final String address;
  final String image;
  final String description;
  final PointModel point;
  final int price_level;
  final double rating;
  final List<dynamic> services;
  final List<dynamic> available_slots;




  WashModel.fromJson(Map json) :
        id = json['id'],
        name = json['name'],
        image = json['image'],
        description = json['description'],
        point = PointModel.fromJson({
          "lat" : json['lat'],
          "long": json['long']
        }),
        rating = json['rating'],
        price_level = json['price_level'],
        address = json['address'],
        services = json['services'],
        available_slots = json['pk_available_slots'];
}