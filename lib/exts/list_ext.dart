extension ForEach  <T> on List<T>{
  void forEachIndexed(Function(int, T) action){
    for(int i =0; i < length; i++){
      action.call(i, this[i]);
    }

  }
}