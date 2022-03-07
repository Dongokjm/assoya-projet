import 'package:intl/intl.dart';

class Vehicule {
  int? id;
  String? reference;
  String? userId;
  String? proprietaireId;
  String? marque;
  String? modele;
  String? couleur;
  String? immatriculation;
  String? dateMiseEnService;
  String? typeCarburant;
  String? assurance;
  String? imageAssurance;
  String? dateAssuranceDebut;
  String? dateAssuranceFin;
  String? visiteTechnique;
  String? dateDebutVisite;
  String? dateFinVisite;
  String? vitesse;
  String? typeBoite;
  String? nombrePlace;
  String? categorieVehicule;
  String? ptac;
  String? anneeUtilisation;
  String? variante;
  String? photo;
  String? etat;
  String? imageVisiteTechnique;
  String? createdAt;
  String? updatedAt;

  Vehicule(
      {this.id,
      this.reference,
      this.userId,
      this.proprietaireId,
      this.marque,
      this.modele,
      this.couleur,
      this.immatriculation,
      this.dateMiseEnService,
      this.typeCarburant,
      this.assurance,
      this.imageAssurance,
      this.dateAssuranceDebut,
      this.dateAssuranceFin,
      this.visiteTechnique,
      this.dateDebutVisite,
      this.dateFinVisite,
      this.vitesse,
      this.typeBoite,
      this.nombrePlace,
      this.categorieVehicule,
      this.ptac,
      this.anneeUtilisation,
      this.variante,
      this.photo,
      this.etat,
      this.imageVisiteTechnique,
      this.createdAt,
      this.updatedAt});

  Vehicule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reference = json['reference'];
    userId = json['user_id'];
    proprietaireId = json['proprietaire_id'];
    marque = json['marque'];
    modele = json['modele'];
    couleur = json['couleur'];
    immatriculation = json['immatriculation'];
    dateMiseEnService = json['date_mise_en_service'];
    typeCarburant = json['type_carburant'];
    assurance = json['assurance'];
    imageAssurance = json['image_assurance'];
    dateAssuranceDebut = json['date_assurance_debut'];
    dateAssuranceFin = json['date_assurance_fin'];
    visiteTechnique = json['visite_technique'];
    dateDebutVisite = json['date_debut_visite'];
    dateFinVisite = json['date_fin_visite'];
    vitesse = json['vitesse'];
    typeBoite = json['type_boite'];
    nombrePlace = json['nombre_place'];
    categorieVehicule = json['categorie_vehicule'];
    ptac = json['ptac'];
    anneeUtilisation = json['annee_utilisation'];
    variante = json['variante'];
    photo = json['photo'];
    etat = json['etat'];
    imageVisiteTechnique = json['image_visite_technique'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['user_id'] = this.userId;
    data['proprietaire_id'] = this.proprietaireId;
    data['marque'] = this.marque;
    data['modele'] = this.modele;
    data['couleur'] = this.couleur;
    data['immatriculation'] = this.immatriculation;
    data['date_mise_en_service'] = this.dateMiseEnService;
    data['type_carburant'] = this.typeCarburant;
    data['assurance'] = this.assurance;
    data['image_assurance'] = this.imageAssurance;
    data['date_assurance_debut'] = this.dateAssuranceDebut;
    data['date_assurance_fin'] = this.dateAssuranceFin;
    data['visite_technique'] = this.visiteTechnique;
    data['date_debut_visite'] = this.dateDebutVisite;
    data['date_fin_visite'] = this.dateFinVisite;
    data['vitesse'] = this.vitesse;
    data['type_boite'] = this.typeBoite;
    data['nombre_place'] = this.nombrePlace;
    data['categorie_vehicule'] = this.categorieVehicule;
    data['ptac'] = this.ptac;
    data['annee_utilisation'] = this.anneeUtilisation;
    data['variante'] = this.variante;
    data['photo'] = this.photo;
    data['etat'] = this.etat;
    data['image_visite_technique'] = this.imageVisiteTechnique;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  Map<String, dynamic> toFormJson() {
    DateFormat format = DateFormat("yyyy-MM-dd");
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['user_id'] = this.userId;
    data['proprietaire_id'] = this.proprietaireId;
    data['marque'] = this.marque;
    data['modele'] = this.modele;
    data['couleur'] = this.couleur;
    data['immatriculation'] = this.immatriculation;
    if (data['date_mise_en_service'] != null) {
      data['date_mise_en_service'] = format.parse(this.dateMiseEnService!);
    }
    data['type_carburant'] = this.typeCarburant;
    data['assurance'] = this.assurance;
    data['image_assurance'] = this.imageAssurance;
    if (data['date_assurance_debut'] != null) {
      data['date_assurance_debut'] = format.parse(this.dateAssuranceDebut!);
    }
    if (data['date_assurance_fin'] != null) {
      data['date_assurance_fin'] = format.parse(this.dateAssuranceFin!);
    }

    data['visite_technique'] = this.visiteTechnique;

    if (data['date_debut_visite'] != null) {
      data['date_debut_visite'] = format.parse(this.dateDebutVisite!);
    }
    if (data['date_fin_visite'] != null) {
      data['date_fin_visite'] = format.parse(this.dateFinVisite!);
    }
    data['vitesse'] = this.vitesse;
    data['type_boite'] = this.typeBoite;
    data['nombre_place'] = this.nombrePlace;
    data['categorie_vehicule'] = this.categorieVehicule;
    data['ptac'] = this.ptac;
    data['annee_utilisation'] = this.anneeUtilisation;
    data['variante'] = this.variante;
    data['photo'] = this.photo;
    data['etat'] = this.etat;
    data['image_visite_technique'] = this.imageVisiteTechnique;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
