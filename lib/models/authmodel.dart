class Loginmodel {
  String? username;
  String? password;

  Loginmodel({required this.username, required this.password});

  String? get getusername => username; //getter

  set setusername(String value) => username = value; //setter

  Map<String, dynamic> toJson() {
    //IMPORTANTE TOJSON DEVE ESSERE SCRITTO COSì SENNO NON RIESCE A TRADURRE OGGETTO DART IN JSON DANDO ECCEZIONE
    return {'username': username, 'password': password};
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
      {required this.username,
      required this.name,
      required this.email,
      required this.confirmpassword,
      required this.password,
      required this.surname});

  Map<String, dynamic> toJson() {
    return {
      'Username': username,
      'name': name,
      'surname': surname,
      'Email': email,
      'Password': password,
      'Confirmapassword': confirmpassword
    };
  }
}
