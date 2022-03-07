class User {
  int? id;
  String? login;
  String? password;
  String? token;

  User({this.id, this.login, this.password, this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    login = json['login'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['login'] = this.login;
    data['token'] = this.token;
    return data;
  }
}
