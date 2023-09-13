import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:police/core/uk_police_api.dart';

class AutoCaller {

  Future<bool> emergencyCall() async{
    bool? res = await FlutterPhoneDirectCaller
        .callNumber(UKPoliceApi.ukEmergencyNumber);
    return res ?? false;
  }
}