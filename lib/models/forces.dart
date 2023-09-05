class Forces{
  String name;
  String id;
  String country;

  Forces(this.id, this.name, this.country);

  factory Forces.fromJson(Map<String, dynamic> json){
    return Forces(json['id'], json['name'], "United Kingdom");
  }

}