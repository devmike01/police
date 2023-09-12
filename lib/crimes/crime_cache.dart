class CrimeCache{
  Map<String, dynamic> _cache = {};

  static CrimeCache? obj;

  CrimeCache(){}

  CrimeCache instance(){
    if(obj ==null){
      obj = CrimeCache();
      return obj!;
    }else{
      return obj!;
    }
  }

  void add<T>(String key, T data, {Function(T)? cachedData}){
    _cache[key] =data;
    cachedData?.call(data);
  }

  T? get<T>(String key){
    return _cache[key];
  }


}