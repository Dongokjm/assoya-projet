import 'package:intl/intl.dart';

class UserProfile {
  int? id;
  String? reference;
  String? name;
  String? lastName;
  String? dateNaissance;
  String? typeUser;
  String? telephone;
  String? photo;
  String? email;
  String? portable;
  String? numeroPermis;
  String? numCni;
  String? adresse;
  String? sexe;
  String? villeId;
  String? paysId;
  String? communeId;
  String? paysOrigine;
  String? login;
  String? codeVerification;
  String? experienceConducteur;
  String? photoCniRecto;
  String? photoCniVerso;
  String? photoPermis;
  String? emailVerifiedAt;
  String? lienFacebook;
  String? lienTwitter;
  String? lienLinkedin;
  String? lienGooglePlus;
  String? apiToken;
  String? rememberToken;
  String? createdAt;
  String? updatedAt;
  String? etat;
  String? permisVerso;
  String? categoriePermis;
  String? permisEtabliLe;
  String? expirationPermis;
  String? dateEmissionCni;
  String? expirationCni;

  UserProfile(
      {this.id,
      this.reference,
      this.name,
      this.lastName,
      this.dateNaissance,
      this.typeUser,
      this.telephone,
      this.photo,
      this.email,
      this.portable,
      this.numeroPermis,
      this.numCni,
      this.adresse,
      this.sexe,
      this.villeId,
      this.paysId,
      this.communeId,
      this.paysOrigine,
      this.login,
      this.codeVerification,
      this.experienceConducteur,
      this.photoCniRecto,
      this.photoCniVerso,
      this.photoPermis,
      this.emailVerifiedAt,
      this.lienFacebook,
      this.lienTwitter,
      this.lienLinkedin,
      this.lienGooglePlus,
      this.apiToken,
      this.rememberToken,
      this.createdAt,
      this.updatedAt,
      this.etat,
      this.permisVerso,
      this.categoriePermis,
      this.permisEtabliLe,
      this.expirationPermis,
      this.dateEmissionCni,
      this.expirationCni});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    reference = json['reference'] ?? "";
    name = json['name'] ?? "";
    lastName = json['last_name'] ?? "";
    dateNaissance = json['date_naissance'] ?? "";
    typeUser = json['type_user'] ?? "";
    telephone = json['telephone'] ?? "";
    photo = json['photo'] ?? "";
    email = json['email'] ?? "";
    portable = json['portable'] ?? "";
    numeroPermis = json['numero_permis'] ?? "";
    numCni = json['num_cni'] ?? "";
    adresse = json['adresse'] ?? "";
    sexe = json['sexe'] ?? "";
    villeId = json['ville_id'] ?? "";
    paysId = json['pays_id'] ?? "";
    communeId = json['commune_id'] ?? "";
    paysOrigine = json['pays_origine'] ?? "";
    login = json['login'] ?? "";
    codeVerification = json['code_verification'] ?? "";
    experienceConducteur = json['experience_conducteur'] ?? "";
    photoCniRecto = json['photo_cni_recto'] ?? "";
    photoCniVerso = json['photo_cni_verso'] ?? "";
    photoPermis = json['photo_permis'] ?? "";
    emailVerifiedAt = json['email_verified_at'] ?? "";
    lienFacebook = json['lien_facebook'] ?? "";
    lienTwitter = json['lien_twitter'] ?? "";
    lienLinkedin = json['lien_linkedin'] ?? "";
    lienGooglePlus = json['lien_google_plus'] ?? "";
    apiToken = json['api_token'] ?? "";
    rememberToken = json['remember_token'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    etat = json['etat'] ?? "";
    permisVerso = json['permis_verso'] ?? "";
    categoriePermis = json['categorie_permis'] ?? "";
    permisEtabliLe = json['permis_etabli_le'] ?? "";
    expirationPermis = json['expiration_permis'] ?? "";
    dateEmissionCni = json['date_emission_cni'] ?? "";
    expirationCni = json['expiration_cni'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    data['date_naissance'] = this.dateNaissance;
    data['type_user'] = this.typeUser;
    data['telephone'] = this.telephone;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['portable'] = this.portable;
    data['numero_permis'] = this.numeroPermis;
    data['num_cni'] = this.numCni;
    data['adresse'] = this.adresse;
    data['sexe'] = this.sexe;
    data['ville_id'] = this.villeId;
    data['pays_id'] = this.paysId;
    data['commune_id'] = this.communeId;
    data['pays_origine'] = this.paysOrigine;
    data['login'] = this.login;
    data['code_verification'] = this.codeVerification;
    data['experience_conducteur'] = this.experienceConducteur;
    data['photo_cni_recto'] = this.photoCniRecto;
    data['photo_cni_verso'] = this.photoCniVerso;
    data['photo_permis'] = this.photoPermis;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['lien_facebook'] = this.lienFacebook;
    data['lien_twitter'] = this.lienTwitter;
    data['lien_linkedin'] = this.lienLinkedin;
    data['lien_google_plus'] = this.lienGooglePlus;
    data['api_token'] = this.apiToken;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['etat'] = this.etat;
    data['permis_verso'] = this.permisVerso;
    data['categorie_permis'] = this.categoriePermis;
    data['permis_etabli_le'] = this.permisEtabliLe;
    data['expiration_permis'] = this.expirationPermis;
    data['date_emission_cni'] = this.dateEmissionCni;
    data['expiration_cni'] = this.expirationCni;
    return data;
  }

  Map<String, dynamic> toFormJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['reference'] = this.reference;
    data['name'] = this.name;
    data['last_name'] = this.lastName;
    if (this.dateNaissance != "") {
      data["date_naissance"] =
          DateFormat('yyyy-MM-dd').parse(this.dateNaissance!);
    } else {
      data["date_naissance"] = DateTime.now();
    }
    data['type_user'] = this.typeUser;
    data['telephone'] = this.telephone;
    data['photo'] = this.photo;
    data['email'] = this.email;
    data['portable'] = this.portable;
    data['numero_permis'] = this.numeroPermis;
    data['num_cni'] = this.numCni;
    data['adresse'] = this.adresse;
    data['sexe'] = this.sexe;
    data['ville_id'] = this.villeId;
    data['pays_id'] = this.paysId;
    data['commune_id'] = this.communeId;
    data['pays_origine'] = this.paysOrigine;
    data['login'] = this.login;
    data['code_verification'] = this.codeVerification;
    data['experience_conducteur'] = this.experienceConducteur;
    data['photo_cni_recto'] = this.photoCniRecto;
    data['photo_cni_verso'] = this.photoCniVerso;
    data['photo_permis'] = this.photoPermis;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['lien_facebook'] = this.lienFacebook;
    data['lien_twitter'] = this.lienTwitter;
    data['lien_linkedin'] = this.lienLinkedin;
    data['lien_google_plus'] = this.lienGooglePlus;
    data['api_token'] = this.apiToken;
    data['remember_token'] = this.rememberToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['etat'] = this.etat;
    data['permis_verso'] = this.permisVerso;
    data['categorie_permis'] = this.categoriePermis;
    if (this.permisEtabliLe != "") {
      data["permis_etabli_le"] =
          DateFormat('yyyy-MM-dd').parse(this.permisEtabliLe!);
    } else {
      data["permis_etabli_le"] = DateTime.now();
    }
    if (this.expirationPermis != "") {
      data["expiration_permis"] =
          DateFormat('yyyy-MM-dd').parse(this.expirationPermis!);
    } else {
      data["expiration_permis"] = DateTime.now();
    }
    if (this.dateEmissionCni != "") {
      data["date_emission_cni"] =
          DateFormat('yyyy-MM-dd').parse(this.dateEmissionCni!);
    } else {
      data["date_emission_cni"] = DateTime.now();
    }
    if (this.expirationCni != "") {
      data["expiration_cni"] =
          DateFormat('yyyy-MM-dd').parse(this.expirationCni!);
    } else {
      data["expiration_cni"] = DateTime.now();
    }

    return data;
  }
}
