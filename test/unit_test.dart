import 'package:flutter_test/flutter_test.dart';
import 'package:police/home/home_content_bloc.dart';

void main(){
  test('Testing change page on button click', (){
    final homeBloc = HomeContentBloc();
    homeBloc.changePage(1);
    homeBloc.on((event, emit) => {

    });
  });
}