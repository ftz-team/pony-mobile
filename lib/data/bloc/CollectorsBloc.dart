import 'package:cybergarden_app/data/models/CollectorModel.dart';
import 'package:cybergarden_app/data/repository/collectorsApi.dart';
import 'package:rxdart/rxdart.dart';

class CollectorsBloc{

  final List filters = ['Все','Для пластика', 'Для стекла', 'Для бумаги', 'Для батареек'];
  final List filtersApi = [ 'all', 'plastic', 'glass', 'paper' , 'batteries'];

  int _active = 0;

  List <CollectorModel> _collectors= [];
  CollectorsBloc(){
    _activeFilter.add(0);
  }

  final _activeFilter = PublishSubject<int>();
  Stream<int> get activeFilter => _activeFilter.stream;


  final _collectorsFetcher = PublishSubject<List<CollectorModel>>();
  Stream<List<CollectorModel>> get collectors => _collectorsFetcher.stream;

  final _activeCollector = PublishSubject<CollectorModel>();
  Stream<CollectorModel> get activeCollector => _activeCollector.stream;

  loadCollectors() async{
    _collectors = await getCollectors(filtersApi[_active]);

    _collectorsFetcher.add(_collectors);
    _activeFilter.add(_active);

  }

  addActive(CollectorModel cly) {

    _activeCollector.sink.add(cly);
  }

  setActive(int active) async{
    _active = active;
    _activeFilter.add(_active);
    loadCollectors();
  }

  likeCollector(CollectorModel collector) async {
    if (collector.liked){
      await likeCollectorApi("remove", collector.id);
    }else{
      await likeCollectorApi("add", collector.id);
    }
    loadCollectors();
  }





}

CollectorsBloc collectorsBloc = new CollectorsBloc();