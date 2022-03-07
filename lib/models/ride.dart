class Ride {
  int? id;
  String? reference;
  String? userId;
  String? communeDepart;
  String? communeArrivee;
  String? quartierDepart;
  String? quartierArrivee;
  String? addresseDepart;
  String? addresseArrivee;
  String? itineraire;
  String? tarifConducteur;
  String? prixCalcule;
  String? prixPromotionnel;
  String? tauxReduction;
  String? typePaiement;
  String? typeTrajet;
  String? photo;
  String? etat;
  String? statut;
  String? places;
  String? vehiculeId;
  String? addressLatitude;
  String? addressLongitude;
  String? addressDestLatitude;
  String? addressDestLongitude;
  String? heureDepart;
  String? heureArrivee;
  String? debutCourses;
  String? finCourses;
  String? createdAt;
  String? updatedAt;
  String? villeDepart;
  String? paysDepart;
  String? regionDepart;
  String? departementDepart;
  String? villeArrivee;
  String? paysArrivee;
  String? regionArrivee;
  String? departementArrivee;
  String? description;
  String? libelleTrajet;

  Ride(
      {this.id,
      this.reference,
      this.userId,
      this.communeDepart,
      this.communeArrivee,
      this.quartierDepart,
      this.quartierArrivee,
      this.addresseDepart,
      this.addresseArrivee,
      this.itineraire,
      this.tarifConducteur,
      this.prixCalcule,
      this.prixPromotionnel,
      this.tauxReduction,
      this.typePaiement,
      this.typeTrajet,
      this.photo,
      this.etat,
      this.statut,
      this.places,
      this.vehiculeId,
      this.addressLatitude,
      this.addressLongitude,
      this.addressDestLatitude,
      this.addressDestLongitude,
      this.heureDepart,
      this.heureArrivee,
      this.debutCourses,
      this.finCourses,
      this.createdAt,
      this.updatedAt,
      this.villeDepart,
      this.paysDepart,
      this.regionDepart,
      this.departementDepart,
      this.villeArrivee,
      this.paysArrivee,
      this.regionArrivee,
      this.departementArrivee,
      this.description,
      this.libelleTrajet});

  Ride.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    userId = json['user_id'];
    communeDepart = json['commune_depart'];
    communeArrivee = json['commune_arrivee'];
    quartierDepart = json['quartier_depart'];
    quartierArrivee = json['quartier_arrivee'];
    addresseDepart = json['addresse_depart'];
    addresseArrivee = json['addresse_arrivee'];
    itineraire = json['itineraire'];
    tarifConducteur = json['tarif_conducteur'];
    prixCalcule = json['prix_calcule'];
    prixPromotionnel = json['prix_promotionnel'];
    tauxReduction = json['taux_reduction'];
    typePaiement = json['type_paiement'];
    typeTrajet = json['type_trajet'];
    photo = json['photo'];
    etat = json['etat'];
    statut = json['statut'];
    places = json['places'];
    vehiculeId = json['vehicule_id'];
    addressLatitude = json['address_latitude'];
    addressLongitude = json['address_longitude'];
    addressDestLatitude = json['address_dest_latitude'];
    addressDestLongitude = json['address_dest_longitude'];
    heureDepart = json['heure_depart'];
    heureArrivee = json['heure_arrivee'];
    debutCourses = json['debut_courses'];
    finCourses = json['fin_courses'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    villeDepart = json['ville_depart'];
    paysDepart = json['pays_depart'];
    regionDepart = json['region_depart'];
    departementDepart = json['departement_depart'];
    villeArrivee = json['ville_arrivee'];
    paysArrivee = json['pays_arrivee'];
    regionArrivee = json['region_arrivee'];
    departementArrivee = json['departement_arrivee'];
    description = json['description'];
    libelleTrajet = json['libelle_trajet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['user_id'] = this.userId;
    data['commune_depart'] = this.communeDepart;
    data['commune_arrivee'] = this.communeArrivee;
    data['quartier_depart'] = this.quartierDepart;
    data['quartier_arrivee'] = this.quartierArrivee;
    data['addresse_depart'] = this.addresseDepart;
    data['addresse_arrivee'] = this.addresseArrivee;
    data['itineraire'] = this.itineraire;
    data['tarif_conducteur'] = this.tarifConducteur;
    data['prix_calcule'] = this.prixCalcule;
    data['prix_promotionnel'] = this.prixPromotionnel;
    data['taux_reduction'] = this.tauxReduction;
    data['type_paiement'] = this.typePaiement;
    data['type_trajet'] = this.typeTrajet;
    data['photo'] = this.photo;
    data['etat'] = this.etat;
    data['statut'] = this.statut;
    data['places'] = this.places;
    data['vehicule_id'] = this.vehiculeId;
    data['address_latitude'] = this.addressLatitude;
    data['address_longitude'] = this.addressLongitude;
    data['address_dest_latitude'] = this.addressDestLatitude;
    data['address_dest_longitude'] = this.addressDestLongitude;
    data['heure_depart'] = this.heureDepart;
    data['heure_arrivee'] = this.heureArrivee;
    data['debut_courses'] = this.debutCourses;
    data['fin_courses'] = this.finCourses;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['ville_depart'] = this.villeDepart;
    data['pays_depart'] = this.paysDepart;
    data['region_depart'] = this.regionDepart;
    data['departement_depart'] = this.departementDepart;
    data['ville_arrivee'] = this.villeArrivee;
    data['pays_arrivee'] = this.paysArrivee;
    data['region_arrivee'] = this.regionArrivee;
    data['departement_arrivee'] = this.departementArrivee;
    data['description'] = this.description;
    data['libelle_trajet'] = this.libelleTrajet;
    return data;
  }
}
