class Loginmodel {
  String? username;
  String? password;

  Loginmodel({required this.username, required this.password});

  String? get getusername => username; //getter

  set setusername(String value) => username = value; //setter

  Map<String, dynamic> toJson() {
    //IMPORTANTE TOJSON DEVE ESSERE SCRITTO COSì SENNO NON RIESCE A TRADURRE OGGETTO DART IN JSON DANDO ECCEZIONE
    return <String, dynamic>{'username': username, 'password': password};
  }
}

//fromjson=> da json a oggetto Dart
//tojson=> da oggetto Dart a json
class Registermodel {
  String? username;
  String? name;
  String? surname;
  String? email;
  String? password;
  String? confirmpassword;

  Registermodel(
      {this.username,
      this.name,
      this.email,
      this.confirmpassword,
      this.password,
      this.surname});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Username': username,
      'Surname': surname,
      'Password': password,
      'ConfirmPassword': confirmpassword,
      'Email': email
    };
  }
}

/*class Tokenmodel {
  String? token;
  DateTime? expiration;

  Tokenmodel({this.token, this.expiration});

  Tokenmodel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
  }
}*/
