class NeigbourhoodEvents {
  Null? description;
  String? title;
  String? address;
  String? type;
  String? startDate;
  String? endDate;

  NeigbourhoodEvents(
      {this.description,
        this.title,
        this.address,
        this.type,
        this.startDate,
        this.endDate});

  NeigbourhoodEvents.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    title = json['title'];
    address = json['address'];
    type = json['type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['title'] = this.title;
    data['address'] = this.address;
    data['type'] = this.type;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    return data;
  }
}