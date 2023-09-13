abstract class BaseState<T>{
  abstract T? data;
  abstract String? message;
  abstract bool isLoading;

  bool get hasData => data != null;
  bool get hasError => message != null;
}