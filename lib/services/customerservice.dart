import 'dart:convert';
import 'package:authapi/models/customermodel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';

const String customerbaseurl = "http://10.0.2.2:5000/api/Customer";
const String uploadimagebaseurl =
    "http://10.0.2.2:5000/api/UploadimagefileFlutter";

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

Future<bool> UpdateCustomer({required Customermodel model}) async {
  Response r = await http.put(Uri.parse('$customerbaseurl/Updatecustomer'),
      body: model.toJson(),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json'
      });
  if (r.statusCode == 200) {
    bool response = r.body == 'true';
    return response;
  } else {
    return false;
  }
}

Future<StreamedResponse> Uploadprofilepicture(
    {required XFile file, required String username}) async {
  MultipartRequest request = http.MultipartRequest(
    'POST',
    Uri.parse(
        '$uploadimagebaseurl/Uploadprofilepicturetoblobstorage/$username'),
  )..files.add(await MultipartFile.fromPath('profilepicture', file.path));
  StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    return response;
  } else {
    return response;
  }
}
