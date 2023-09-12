import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/exts/list_ext.dart';
import 'package:police/repository/police_repository.dart';

import '../models/category_crime_by_location.dart';
import '../models/crime_at_location.dart';
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
    if(titles.isEmpty) {
      loadData(0);
    }else{
      loadNewData(titles[0]);
    }
  }

  void loadNewData(String? key){

    if(key == null)return;
    if(mapped[key] != null) {

      print("mapped ==> ${mapped[key]}");
      final changedData = mapped[key] ?? [];
      emit(ChangePageState(categories: mapped.keys.toList(), crimes: changedData));
    }
  }

  void loadData(int pos) async{
    final crimes = await _repo.crimeAtLocation(date,
        lat, lng);

    if(crimes.hasError()){
      emit(ChangePageState(errorMsg: crimes.errorMsg));
    }


    if( crimes.hasData()){
      crimes.getData().forEachIndexed((index, e){
        final oldCate = e.category?.split("-");
        String newCate ='';
        oldCate?.forEach((element) {
          final firstChar = element.substring(0, 1).toUpperCase();
          newCate += "${firstChar + element.substring(1)} ";
        });
        final update = mapped[newCate] ?? [e];
        int lIndex = update.indexOf(e);

        if(lIndex > -1){
          // Recurring
          final m = update[lIndex];
          m.count +=1;
          update[lIndex] = m;
        }else{
          // New instance
          update.add(e);
        }

        mapped[newCate] = update;
      });

      List<CrimeAtLocation> crimesAtLoc =[];
      // titles.clear();
      mapped.forEach((key, crimes) {
        crimesAtLoc.addAll(crimes);
      });

      emit(ChangePageState(items: categoryCrimes, crimes: crimesAtLoc,
          categories: mapped.keys.toList()));
    }
  }

}