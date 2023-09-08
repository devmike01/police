class LatLng{
  double lat;
  double lng;
  LatLng(this.lat, this.lng);

  factory LatLng.fromJson(Map<String, dynamic> json){
    //double lat, double lng
    return LatLng(json['lat'], json['lng']);
  }

  Map<String, double> toJson(){
    return {
      'lat': lat,
      'lng': lng
    };
  }

}