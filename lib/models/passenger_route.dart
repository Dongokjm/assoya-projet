class PassengerRoute {
  String? origin;
  String? destination;
  String? date;

  PassengerRoute({
    this.origin,
    this.destination,
    this.date,
  });

  PassengerRoute.fromJson(Map<String, dynamic> json) {
    origin = json['origin'] ?? "";
    destination = json['destination'] ?? "";
    destination = json['date'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['origin'] = this.origin;
    data['destination'] = this.destination;
    data['date'] = this.destination;
    return data;
  }
}
