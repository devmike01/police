class ApiClient<T>{
  T? data;
  String? errorMsg;

  ApiClient({this.data, this.errorMsg});
  
  bool hasData() => data != null;
  
  bool hasError() => errorMsg != null;
}