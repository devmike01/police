class NeigbourhoodDetails {
  String? urlForce;
  ContactDetails? contactDetails;
  String? name;
  List<Links>? links;
  Centre? centre;
  List<Locations>? locations;
  String? description;
  String? id;
  String? population;

  NeigbourhoodDetails(
      {this.urlForce,
        this.contactDetails,
        this.name,
        this.links,
        this.centre,
        this.locations,
        this.description,
        this.id,
        this.population});

  NeigbourhoodDetails.fromJson(Map<String, dynamic> json) {
    urlForce = json['url_force'];
    contactDetails = json['contact_details'] != null
        ? new ContactDetails.fromJson(json['contact_details'])
        : null;
    name = json['name'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    centre =
    json['centre'] != null ? new Centre.fromJson(json['centre']) : null;
    if (json['locations'] != null) {
      locations = <Locations>[];
      json['locations'].forEach((v) {
        locations!.add(new Locations.fromJson(v));
      });
    }
    description = json['description'];
    id = json['id'];
    population = json['population'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url_force'] = this.urlForce;
    if (this.contactDetails != null) {
      data['contact_details'] = this.contactDetails!.toJson();
    }
    data['name'] = this.name;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    if (this.centre != null) {
      data['centre'] = this.centre!.toJson();
    }
    if (this.locations != null) {
      data['locations'] = this.locations!.map((v) => v.toJson()).toList();
    }
    data['description'] = this.description;
    data['id'] = this.id;
    data['population'] = this.population;
    return data;
  }
}

class ContactDetails {
  String? twitter;
  String? facebook;
  String? telephone;
  String? email;

  ContactDetails({this.twitter, this.facebook, this.telephone, this.email});

  ContactDetails.fromJson(Map<String, dynamic> json) {
    twitter = json['twitter'];
    facebook = json['facebook'];
    telephone = json['telephone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    data['telephone'] = this.telephone;
    data['email'] = this.email;
    return data;
  }
}

class Links {
  String? url;
  Null? description;
  String? title;

  Links({this.url, this.description, this.title});

  Links.fromJson(Map<String, dynamic> json) {
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

class Centre {
  String? latitude;
  String? longitude;

  Centre({this.latitude, this.longitude});

  Centre.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Locations {
  String? name;
  double? longitude;
  String? postcode;
  String? address;
  double? latitude;
  String? type;
  String? description;

  Locations(
      {this.name,
        this.longitude,
        this.postcode,
        this.address,
        this.latitude,
        this.type,
        this.description});

  Locations.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    longitude = json['longitude'];
    postcode = json['postcode'];
    address = json['address'];
    latitude = json['latitude'];
    type = json['type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['longitude'] = this.longitude;
    data['postcode'] = this.postcode;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['type'] = this.type;
    data['description'] = this.description;
    return data;
  }
}