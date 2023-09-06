class EmergencyNum{
  String title;
  String number;

  EmergencyNum(this.title, this.number);

  factory EmergencyNum.fromJson(Map<String,dynamic> json){
    return EmergencyNum(json["title"], json['number']);
  }
}