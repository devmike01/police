class CrimeCategory {
  String? url;
  String? name;

  CrimeCategory({this.url, this.name});

  CrimeCategory.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    return data;
  }
}
