class StopSearch {
  String? ageRange;
  String? outcome;
  bool? involvedPerson;
  String? selfDefinedEthnicity;
  String? gender;
  String? legislation;
  bool? outcomeLinkedToObjectOfSearch;
  String? datetime;
  bool? removalOfMoreThanOuterClothing;
  OutcomeObject? outcomeObject;
  Location? location;
  dynamic operation;
  String? officerDefinedEthnicity;
  String? type;
  dynamic operationName;
  String? objectOfSearch;

  StopSearch(
      {this.ageRange,
        this.outcome,
        this.involvedPerson,
        this.selfDefinedEthnicity,
        this.gender,
        this.legislation,
        this.outcomeLinkedToObjectOfSearch,
        this.datetime,
        this.removalOfMoreThanOuterClothing,
        this.outcomeObject,
        this.location,
        this.operation,
        this.officerDefinedEthnicity,
        this.type,
        this.operationName,
        this.objectOfSearch});

  StopSearch.fromJson(Map<String, dynamic> json) {
    ageRange = json['age_range'];
    outcome = json['outcome'];
    involvedPerson = json['involved_person'];
    selfDefinedEthnicity = json['self_defined_ethnicity'];
    gender = json['gender'];
    legislation = json['legislation'];
    outcomeLinkedToObjectOfSearch = json['outcome_linked_to_object_of_search'];
    datetime = json['datetime'];
    removalOfMoreThanOuterClothing =
    json['removal_of_more_than_outer_clothing'];
    outcomeObject = json['outcome_object'] != null
        ? new OutcomeObject.fromJson(json['outcome_object'])
        : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    operation = json['operation'];
    officerDefinedEthnicity = json['officer_defined_ethnicity'];
    type = json['type'];
    operationName = json['operation_name'];
    objectOfSearch = json['object_of_search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age_range'] = this.ageRange;
    data['outcome'] = this.outcome;
    data['involved_person'] = this.involvedPerson;
    data['self_defined_ethnicity'] = this.selfDefinedEthnicity;
    data['gender'] = this.gender;
    data['legislation'] = this.legislation;
    data['outcome_linked_to_object_of_search'] =
        this.outcomeLinkedToObjectOfSearch;
    data['datetime'] = this.datetime;
    data['removal_of_more_than_outer_clothing'] =
        this.removalOfMoreThanOuterClothing;
    if (this.outcomeObject != null) {
      data['outcome_object'] = this.outcomeObject!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['operation'] = this.operation;
    data['officer_defined_ethnicity'] = this.officerDefinedEthnicity;
    data['type'] = this.type;
    data['operation_name'] = this.operationName;
    data['object_of_search'] = this.objectOfSearch;
    return data;
  }
}

class OutcomeObject {
  String? id;
  String? name;

  OutcomeObject({this.id, this.name});

  OutcomeObject.fromJson(Map<String, dynamic> json) {
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