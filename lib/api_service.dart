import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  // static String Base_url = 'http://192.168.0.139:3000/';    //hp
  // static String Base_url = 'http://192.168.0.115:5000/'; //Mac
  static String Base_url = 'https://prttest.watchyourhealth.com/funtech/challanges/app/';

  //Generate a primeID for new user after successful response
  Future<dynamic> PostApis(String url, String body, String token) async {
    var responseJson;
    try {
      final http.Response response = await http.post(Uri.parse(Base_url + url),
          headers: <String, String>{
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
            'Accept': '*/*',
          },
          body: body);
      print("token");
      print('Bearer $token');
      // headers: <String, String>{"Content-Type": "application/json"},;

      responseJson = json.decode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> DeleteApis(String url, String body, String token) async {
    var responseJson;
    try {
      final http.Response response =
          await http.delete(Uri.parse(Base_url + url),
              headers: <String, String>{
                "Content-Type": "application/json",
                'Authorization': 'Bearer ${token}',
                'Accept': '*/*',
              },
              body: body);
      print("token");
      print('Bearer $token');
      // headers: <String, String>{"Content-Type": "application/json"},;

      responseJson = json.decode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> PutApis(String url, String body, String token) async {
    var responseJson;
    try {
      final http.Response response = await http.put(Uri.parse(Base_url + url),
          headers: <String, String>{
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
            'Accept': '*/*',
          },
          body: body);
      print("token");
      print('Bearer $token');
      // headers: <String, String>{"Content-Type": "application/json"},;

      responseJson = json.decode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> PatchApis(String url, String body, String token) async {
    var responseJson;
    try {
      final http.Response response = await http.patch(Uri.parse(Base_url + url),
          headers: <String, String>{
            "Content-Type": "application/json",
            'Authorization': 'Bearer ${token}',
            'Accept': '*/*',
          },
          body: body);
      print("token");
      print('Bearer $token');
      // headers: <String, String>{"Content-Type": "application/json"},;

      responseJson = json.decode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> GetRequest(String url, {String token = ''}) async {
    var responseJson;
    try {
      final http.Response response = await http.get(
        Uri.parse(Base_url + url),
        // headers: <String, String>{"Content-Type": "application/json"},
        headers: <String, String>{
          "Content-Type": "application/json",
          'Authorization': 'Bearer ${token}',
          'Accept': '*/*',
        },
      );
      // headers: <String, String>{"Content-Type": "application/json"},;

      responseJson = json.decode(response.body);
      print(responseJson);
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  getSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  }
}
