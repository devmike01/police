import 'package:police/core/api_client_state.dart';

abstract class Repository{

  Future<ApiClient<T>> getWork<T>(Future<T> Function() func) async{
    try{
      final response = await func.call();
      return ApiClient(data: response);
    }catch (error){
      return ApiClient(message: error.toString());
    }
  }
}