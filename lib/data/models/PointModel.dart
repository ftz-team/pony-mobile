class PointModel{

    final double long;
   final  double lat;

  PointModel({
    required this.long ,
    required this.lat
  });

  PointModel.fromJson(Map<dynamic, dynamic> json):
    long = json['long'],
    lat = json['lat'];

}