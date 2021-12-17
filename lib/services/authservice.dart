import 'dart:convert';

import 'package:authapi/models/authmodel.dart';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;

const String apibaseurl = "http://10.0.2.2:5000/api";

Future<void> login(Loginmodel user) async {
  Response r = await http.post(Uri.parse("$apibaseurl/Auth/Login"),
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      });
  if (r.statusCode == 200) {
    print(r.body);
  } else {
    print('si è verificato un errore');
    print(r.body);
  }
}

Future<bool> register(Registermodel registermodel) async {
  Response r = await http.post(Uri.parse("$apibaseurl/Auth/Register"),
      body: jsonEncode(registermodel),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      });
  if (r.statusCode == 200) {
    return true;
  } else {
    return false;
  }
}
