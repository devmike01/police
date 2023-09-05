import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:police/forces/search_event.dart';
import 'package:police/forces/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState>{

  bool? fieldShow;
  
  SearchBloc(): super(SearchState.none()){
    on<ClickSearchEvent>((event, emit) => emit(SearchState(showField: event.showField)));
    on<SearchTextEvent>((event, emit) => emit(SearchState(showField: true,
        searchText: event.text)));
  }
  
  void showField(){
    fieldShow = true;
    add(ClickSearchEvent(true));
  }

  void hideField(){
    fieldShow = false;
    add(ClickSearchEvent(false));
  }

  void searchText(String text){
    add(SearchTextEvent(text));
  }
}