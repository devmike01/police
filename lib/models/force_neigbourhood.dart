class ForceNeigbourhood {
  String? id;
  String? name;
  String? forceId;

  ForceNeigbourhood({this.id, this.name, this.forceId});

  ForceNeigbourhood.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
