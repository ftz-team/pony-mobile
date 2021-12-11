import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:cybergarden_app/data/repository/washesApi.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc{

  int time = 1;
  int type = 0 ;

  final _activeFilters = PublishSubject<Map>();
  Stream<Map> get activeFilters => _activeFilters.stream;

  CheckoutBloc(){
    updateFilters();

  }

  updateFilters(){
  _activeFilters.add({
    "time": time,
    "type": type
  });
  }

  setTime(int time){
    this.time = time;
    updateFilters();
  }

  setType(int type){
    this.type = type;
    updateFilters();
  }


}

CheckoutBloc checkoutBloc = CheckoutBloc();