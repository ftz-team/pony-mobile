import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/authApi.dart';
import 'package:dio/dio.dart';

import '../dateHelpers.dart';
import 'default.dart';

Future<List<WashModel>> getWashes(List<int> types, List<int> times, int sort) async{

  List<WashModel> res= [];

  Dio dio = await getApiClient();

  String url = '/wash/list/?';

  if (times.length!=0){
    url+="slot="+times[0].toString()+"&";
  }

  if (types.length!=0){
    url+="service="+types[0].toString()+"&";
  }

  print(url);

  var response = await dio.get(url);

  if (response.statusCode == 200){
    for (var json in response.data){
      res.add(WashModel.fromJson(json));
    }
    return res;
  }else{
    return [];
  }

}

Future<bool> createReservation(int washId, int slot) async{
  Dio dio = await getApiClient();
  var user = await getUser();
  var data = await dio.post("/create_reservation/",data: FormData.fromMap({
    "user" : user['id'],
    "wash" : washId,
    "slot" : slot
  }));



  return true;

}

Future<dynamic> getReviews(int mashId) async{
  String url = "/get_reviews/?wash="+mashId.toString();
  Dio dio = await getApiClient();
  var list  =  await dio.get(url);
  return list.data;
}

Future<bool> sendReview(int washId, int rating, String text) async{
  String url = "/create_review/";
  var user = await getUser();
  Dio dio = await getApiClient();
  print(user);
  var data = await dio.post(url,data: FormData.fromMap({
    "user" : user['id'],
    "wash" : washId,
    "text" : text,
    "rating" : rating
  }));
  return true;
}