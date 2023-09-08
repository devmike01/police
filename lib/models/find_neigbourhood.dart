class FindNeigbourhood {
  String? force;
  String? neighbourhood;

  FindNeigbourhood({this.force, this.neighbourhood});

  FindNeigbourhood.fromJson(Map<String, dynamic> json) {
    force = json['force'];
    neighbourhood = json['neighbourhood'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['force'] = force;
    data['neighbourhood'] = neighbourhood;
    return data;
  }
}