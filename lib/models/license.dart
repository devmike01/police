class License{
  String title;
  String license;

  License(this.title, this.license);

  factory License.from(Map<String, dynamic> json){
    return License(json['title'], json['license']);
  }

  Map<String, dynamic> toJson(){
    return {
      'title' :title,
      'license': license
    };
  }
}