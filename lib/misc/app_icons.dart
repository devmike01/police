class AppIcons{
  static String location_ill ="my_location_ic".png();
  static String policeman_ic = "policeman_ic".png();

}

extension AppIconsName on String{
  String png(){
    return "assets/images/$this.png";
  }
}
