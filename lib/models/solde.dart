class Solde {
  String? reference;
  int? numCompte;
  int? userId;
  int? solde;
  String? dateCreation;
  String? typecompte;
  String? updatedAt;
  String? createdAt;
  int? id;

  Solde(
      {this.reference,
      this.numCompte,
      this.userId,
      this.solde,
      this.dateCreation,
      this.typecompte,
      this.updatedAt,
      this.createdAt,
      this.id});

  Solde.fromJson(Map<String, dynamic> json) {
    reference = json['reference'];
    numCompte = json['num_compte'];
    userId = json['user_id'];
    solde = json['solde'];
    dateCreation = json['date_creation'];
    typecompte = json['typecompte'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reference'] = this.reference;
    data['num_compte'] = this.numCompte;
    data['user_id'] = this.userId;
    data['solde'] = this.solde;
    data['date_creation'] = this.dateCreation;
    data['typecompte'] = this.typecompte;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
