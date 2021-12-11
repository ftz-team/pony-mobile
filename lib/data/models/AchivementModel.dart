class AchivementModel{


  final String header;
  final String photo;
  final String description;
  final String? type;


  AchivementModel.fromJson(Map json) :
        header = json['header'],
        photo = json['image'],
        type = json['type'],
        description = json['description'];
}