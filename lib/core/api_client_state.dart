class ApiClient<T>{
  T? data;
  String? errorMsg;

  ApiClient({this.data, this.errorMsg});
  
  bool hasData() => data != null;
  
  bool hasError() => errorMsg != null;

  T getData(){
    if(!hasData()){
      throw Exception("No data! fix your code");
    }
    return data!;
  }

  String getError(){
    if(!hasError()){
      throw Exception("No error! fix your code");
    }
    return errorMsg!;
  }

}