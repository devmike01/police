import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/core/injector.dart';
import 'package:police/repository/police_repository.dart';

import 'crime_page.dart';
import 'crime_tabs_state.dart';

class CrimeTabCubit extends Cubit<CrimeTabState>{

  final _repo = getIt.get<PoliceRepository>();

  CrimeTabCubit(): super(InitialState());

  void changePage(int pos) async{
    List<CrimePage> items =[];
    emit(ChangePageState(items));
  }

}