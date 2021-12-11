import 'package:cybergarden_app/data/models/AchivementModel.dart';
import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:dio/dio.dart';

import '../dateHelpers.dart';
import 'default.dart';

Future<List<CollectorModel>> getCollectors(String filter, {String offline = "false"}) async{



  Dio dio = await getApiClient();

  var response = await dio.get("/collector/get?type="+filter+"&is_offline="+offline, );

  if (response.statusCode == 200){
    List<CollectorModel> res= [];
    for (var json in response.data['data']){
      res.add(CollectorModel.fromJson(json));
    }
    return res;
  }else{
    return [];
  }

}
Future<dynamic> likeCollectorApi(String action , int id) async {
  Dio dio = await getApiClient();
  var response = await dio.get("/collector/add_to_favourites?action="+action+"&id="+id.toString(), );
  return response;
}


Future<Map> checkInCollector(CollectorModel colletor) async{

  Dio dio = await getApiClient();
  var response = await dio.post("/visit/create", data: {
    "collector_id" : colletor.id
  });

  if (response.statusCode == 200){
    if (response.data['new_achievement']){
      print({
        "new_achievement": true,
        "achievement": response.data['new_achievement_data']
      });
      return {
        "new_achievement" : true,
        "achievement" : response.data['new_achievement_data']
      };
    }

    return response.data;
  }

  return response.data;

}


Future<List<CollectorModel>> loadHistory() async{

  Dio dio = await getApiClient();

  var res = await dio.get("/visit/history");

  List<CollectorModel> ans = [];

  res.data['data'].forEach((var el) => {
    ans.add(CollectorModel.fromJson(el['collector'])
    ),
    ans[ans.length-1].visited_at = getDateTimeFromDjango(el['date'])

  });

  return ans;
}