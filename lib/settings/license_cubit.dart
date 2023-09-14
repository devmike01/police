import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/license.dart';

class LicenseCubit extends Cubit<String>{

  LicenseCubit(BuildContext context): super(""){
    loadLicense(context);
  }

  void loadLicense(BuildContext context) async{
    final asset = DefaultAssetBundle.of(context);
    final json = await asset.loadString("assets/json/licenses.json");

    final jsonResult = jsonDecode(json); //
    Iterable<License> licenses = List.from(jsonResult)
        .map((e) => License.from(e));// latest Dart
    String concatHtml = '';
    licenses.forEach((element) {
      concatHtml += element.license;
    });
    emit(concatHtml);
  }

}