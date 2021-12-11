import 'package:cybergarden_app/data/models/WashModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:cybergarden_app/data/repository/washesApi.dart';
import 'package:rxdart/rxdart.dart';

class WashesBloc{

  int _sort = -1;
  List<int> _times = [];
  List<int> _types = [];

  static Map timesHardCode = {
    0: '09:00 - 10:00',
    1: '10:00 - 11:00',
    2: '11:00 - 12:00',
    3: '12:00 - 13:00',
    4: '13:00 - 14:00',
    5: '14:00 - 15:00',
    6: '15:00 - 16:00',
    7: '16:00 - 17:00',
    8: '17:00 - 18:00'
  };

  static Map sortsHardCode = {
    -1: 'По умолчанию',
    0: 'Сначала дешевые',
    1: 'Сначала дорогие',
  };

  static Map typesHardCode = {
    1: 'Кузов',
    2: 'Салон',
    3: 'Комплекс',
  };

  List<WashModel> _washes = [];

  // Filters:
  final _activeFilters = PublishSubject<Map>();
  Stream<Map> get activeFilters => _activeFilters.stream;

  // Washes:
  final _activeWash = PublishSubject<WashModel>();
  Stream<WashModel> get activeWash => _activeWash.stream;

  final _washesList = PublishSubject<List<WashModel>>();
  Stream<List<WashModel>> get washesList => _washesList.stream;

  WashesBloc(){
    _activeFilters.add({
      'sort' : _sort,
      'types' : _types,
      'times' : _times
    });
  }

  updateFilters(){
    print("r u good?");
    _activeFilters.add({
      'sort' : _sort,
      'types' : _types,
      'times' : _times
    });
    loadWashes();
  }

  addActive(WashModel wash) {
    _activeWash.sink.add(wash);
  }

  setTimes(List<int> times){
    print(times);
    _times = times;
    updateFilters();
  }

  setTypes(List<int> types){
    _types = types;
    updateFilters();
  }

  setSort(int sort){
    _sort = sort;
    updateFilters();
  }

  loadWashes() async{
    _washes = await getWashes(_types,_times,_sort);
    _washesList.sink.add(_washes);
  }


}

WashesBloc washesBloc = WashesBloc();