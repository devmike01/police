extension ForEach  <T> on List<T>{
  void forEachIndexed(Function(int, T) action){
    for(int i =0; i < length; i++){
      print("ValueRange01: $i _ $length");
      action.call(i, this[i]);
    }

  }
}