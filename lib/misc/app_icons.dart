class AppIcons{
  static String location_ill ="my_location_ic".png();
  static var policeman_ic = "policeman_ic".png();
  static var settingsIc ="settings_ic".png();
  static var policeType1 ="police_skin_type_1".png();
  static var policeType3 ="police_skin_type_3".png();
  static var policeType5 ="police_skin_type_5".png();
  static var joyfulDoctor ="doctor_ic".png();
  static var currentLocation = "business_location".png();
  static var policeCap ="police_cap".png();
  static var arrest ="arrest".png();
  static const ukPolice ="assets/images/uk_police_group.jpg";

  static var policeIcons = [policeType1, policeType3, policeType5];
}

extension AppIconsName on String{
  String png(){
    return "assets/images/$this.png";
  }
}
