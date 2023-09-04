class Forces{
  String name;
  String id;

  Forces(this.id, this.name);

  factory Forces.fromJson(Map<String, dynamic> json){
    return Forces(json['id'], json['name']);
  }

}