import 'dart:convert';

import 'package:authapi/authutils/tokenstorage.dart';
import 'package:authapi/models/authmodel.dart';

import 'package:http/http.dart';

import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

const String apibaseurl = "http://10.0.2.2:5000/api";

Future<bool> login(Loginmodel user) async {
  Response r = await http.post(Uri.parse("$apibaseurl/Auth/Login"),
      body: jsonEncode(user),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      });
  if (r.statusCode == 200) {
    Map<String, dynamic> jwt = jsonDecode(r.body);
    //chiamare flutter secure storage per salvare token
    await Tokenstorage.savetoken('token', jwt['token']);
    return true;
  } else {
    return false;
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

Future<bool> istokenexpired() async {
  String? token = await Tokenstorage.retrievetokenvalue('token');
  if (token != null && token != "") {
    bool hasExpired = JwtDecoder.isExpired(token);
    if (hasExpired) {
      return true;
    } else {
      return false;
    }
  }
  return true;
}
