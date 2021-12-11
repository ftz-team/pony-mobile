import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/models/WashModel.dart';
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