class SearchState{
  bool showField;
  String? searchText;
  SearchState({this.searchText, this.showField =false});

  factory SearchState.none(){
    return SearchState(searchText: null, showField: false);
  }

  SearchState copy(String? searchText, bool? showField){
    if(searchText != null){
      this.searchText = searchText;
    }

    if(showField != null){
      this.showField = showField;
    }
    return this;
  }

}