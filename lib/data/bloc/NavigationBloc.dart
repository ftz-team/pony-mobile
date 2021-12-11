import 'package:rxdart/rxdart.dart';

class NavigationBloc{

  int _tab = 0;

  final _activeTab = PublishSubject<int>();
  Stream<int> get tab => _activeTab.stream;

  setTab(int newTab){
    _tab = newTab;
    _activeTab.add(_tab);
  }

}

NavigationBloc navigationBloc = NavigationBloc();