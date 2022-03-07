class DriverRoute {
  String? origin;
  String? destination;
  String? price;
  String? vehicule;
  String? nbPlaces;
  List<String>? days;

  DriverRoute(
      {this.origin,
      this.destination,
      this.days,
      this.nbPlaces,
      this.vehicule,
      this.price});

  DriverRoute.fromJson(Map<String, dynamic> json) {
    origin = json['origin'] ?? "";
    origin = json['nbPlaces'] ?? "";
    vehicule = json['vehicule'] ?? "";
    destination = json['destination'] ?? "";
    price = json['price'] ?? "";
    days = json['days'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['price'] = this.price;
    data['nbPlaces'] = this.nbPlaces;
    data['vehicule'] = this.vehicule;
    data['days'] = this.days;
    return data;
  }
}
