class CrimeAtLocation {
  String? category;
  String? locationType;
  Location? location;
  String? context;
  OutcomeStatus? outcomeStatus;
  String? persistentId;
  int? id;
  String? locationSubtype;
  String? month;
  int count =0;


  CrimeAtLocation(
      {this.category,
        this.locationType,
        this.location,
        this.context,
        this.outcomeStatus,
        this.persistentId,
        this.id,
        this.locationSubtype,
        this.month,
      this.count =0});

  CrimeAtLocation.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    locationType = json['location_type'];
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    context = json['context'];
    outcomeStatus = json['outcome_status'] != null
        ? new OutcomeStatus.fromJson(json['outcome_status'])
        : null;
    persistentId = json['persistent_id'];
    id = json['id'];
    locationSubtype = json['location_subtype'];
    month = json['month'];
    count = json['count'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['location_type'] = this.locationType;
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['context'] = this.context;
    if (this.outcomeStatus != null) {
      data['outcome_status'] = this.outcomeStatus!.toJson();
    }
    data['persistent_id'] = this.persistentId;
    data['id'] = this.id;
    data['location_subtype'] = this.locationSubtype;
    data['month'] = this.month;
    data['count'] = count;
    return data;
  }
}

class Location {
  String? latitude;
  Street? street;
  String? longitude;

  Location({this.latitude, this.street, this.longitude});

  Location.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    street =
    json['street'] != null ? new Street.fromJson(json['street']) : null;
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    if (this.street != null) {
      data['street'] = this.street!.toJson();
    }
    data['longitude'] = this.longitude;
    return data;
  }
}

class Street {
  int? id;
  String? name;

  Street({this.id, this.name});

  Street.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class OutcomeStatus {
  String? category;
  String? date;

  OutcomeStatus({this.category, this.date});

  OutcomeStatus.fromJson(Map<String, dynamic> json) {
    category = json['category'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['category'] = this.category;
    data['date'] = this.date;
    return data;
  }
}

