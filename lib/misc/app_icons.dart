class AppIcons{
  static String location_ill ="my_location_ic".png();
  static var policeman_ic = "policeman_ic".png();
  static var settingsIc ="settings_ic".png();

}

extension AppIconsName on String{
  String png(){
    return "assets/images/$this.png";
  }
}
