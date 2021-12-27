import 'dart:convert';
import 'package:authapi/models/customermodel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

const String customerbaseurl = "http://10.0.2.2:5000/api/Customer";

Future<List<Customermodel>> Getall() async {
  Response r = await http.get(Uri.parse('$customerbaseurl/Getallcustomers'));
  if (r.statusCode == 200) {
    List<dynamic> body = jsonDecode(r.body);
    List<Customermodel> allcustomers = body
        .map(
          (customer) => Customermodel.fromMap(customer),
        )
        .toList();
    return allcustomers;
  } else if (r.statusCode == 204) {
    return [];
  } else {
    throw 'unable to retrieve customers';
  }
}

Future<bool> Deletecustomer({required String idcustomer}) async {
  Response r = await http.delete(
    Uri.parse('$customerbaseurl/Deletecustomerbyid/$idcustomer'),
  );
  if (r.statusCode == 200) {
    bool response =
        r.body == 'true'; //non esiste un bool.parse o altro in dart :|
    return response;
  } else {
    return false;
  }
}
