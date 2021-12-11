import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:dio/dio.dart';

import 'default.dart';

Future<List<AchivementModel>> getAll() async{

  Dio dio = await getApiClient();
  var res = await dio.get("/achivements/get");

  List<AchivementModel> itog = [];
  
  res.data['status'].forEach((var a) => {
    itog.add(AchivementModel.fromJson(a))
  });
  
  return itog;

}