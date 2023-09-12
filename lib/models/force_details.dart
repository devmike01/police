class ForceDetails {
  String? description;
  String? url;
  List<EngagementMethods>? engagementMethods;
  String? telephone;
  String? id;
  String? name;

  ForceDetails(
      {this.description,
        this.url,
        this.engagementMethods,
        this.telephone,
        this.id,
        this.name});

  ForceDetails.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    url = json['url'];
    if (json['engagement_methods'] != null) {
      engagementMethods = <EngagementMethods>[];
      json['engagement_methods'].forEach((v) {
        engagementMethods!.add(new EngagementMethods.fromJson(v));
      });
    }
    telephone = json['telephone'];
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['url'] = this.url;
    if (this.engagementMethods != null) {
      data['engagement_methods'] =
          this.engagementMethods!.map((v) => v.toJson()).toList();
    }
    data['telephone'] = this.telephone;
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class EngagementMethods {
  String? url;
  String? description;
  String? title;

  EngagementMethods({this.url, this.description, this.title});

  EngagementMethods.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    description = json['description'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['description'] = this.description;
    data['title'] = this.title;
    return data;
  }
}