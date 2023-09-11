import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/core/latlng.dart';
import 'package:police/repository/police_repository.dart';

import '../models/category_crime_by_location.dart';
import '../models/crime_at_location.dart';
import 'crime_page.dart';
import 'crime_tabs_state.dart';

class CrimeTabCubit extends Cubit<CrimeTabState>{


  Map<String, List<CrimeAtLocation>> mapped = {};
  List<CategoryCrimeByLocation> categoryCrimes =[];


  List<String> titles =[];
  List<List<CrimeAtLocation>> crimes =[];

  final _repo = getIt.get<PoliceRepository>();
  String date;
  double lat;
  double lng;

  CrimeTabCubit(this.date, this.lat,
      this.lng): super(InitialState()){
    loadData(0);
  }

  void loadNewData(int pos, String? key){

    if(key == null)return;
    if(mapped[key] != null) {

      print("mapped ==> ${mapped[key]}");
      final List<CategoryCrimeByLocation> newCategoryCrimes = categoryCrimes;
      // final newList = categoryCrimes.where((element)
      // => element.category == key).toList();

      // newCategoryCrimes.forEach((element) {
      //   element.crimes.clear();
      //   print("object{ ==> ${element.crimes.isEmpty}");
      // });
      newCategoryCrimes[pos].crimes = mapped[key] ?? [];
      emit(ChangePageState(items: newCategoryCrimes));
    }
  }

  void loadData(int pos) async{
    final crimes = await _repo.crimeAtLocation(date,
        lat, lng);

    if(crimes.hasError()){
      emit(ChangePageState(errorMsg: crimes.errorMsg));
    }


    if( crimes.hasData()){
      crimes.getData().forEach((e){
        final oldCate = e.category?.split("-");
        String newCate ='';
        oldCate?.forEach((element) {
          final firstChar = element.substring(0, 1).toUpperCase();
          newCate += "${firstChar + element.substring(1)} ";
        });
        final update = mapped[newCate] ?? [];
        final filters = update.map((cate) => cate.location
            ?.street?.name == e.location?.street?.name);

        if(filters.isNotEmpty){
          e.count = update[update.length-1].count +1;
          update[update.length-1] = e;
        }else {
          e.count = 1;
          update.add(e);
        }

        mapped[newCate] = update;
      });

      mapped.forEach((key, crimes) {
        this.crimes.add(crimes);
        titles.add(key);
        categoryCrimes.add(CategoryCrimeByLocation(key, crimes));
      });

      emit(ChangePageState(items: categoryCrimes));
    }
  }

}