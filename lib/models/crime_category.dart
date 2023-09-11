class CrimeCategory {
  String url;
  String name;

  CrimeCategory({required this.url, required this.name});

  factory CrimeCategory.fromJson(Map<String, dynamic> json) {
    return CrimeCategory(url: json['url'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    return data;
  }
}
