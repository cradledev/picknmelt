import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  final String _endpoint = 'http://kotari.online/api/v1/';
  // final String _url = 'http://kotari.online/';

  Map _user;
  String _token = '';
  SharedPreferences _sp;
  //get
  get endpoint => _endpoint;
  get user => _user;
  get sp => _sp;
  get token => _token;
  // set
  set user(value) {
    _user = value;
    notifyListeners();
  }

  set sp(value) {
    _sp = value;
    notifyListeners();
  }

  set token(value) {
    _token = value;
    notifyListeners();
  }

  void getUserFromStorage() {
    var result = sp.getString('user');
    var token = sp.getString('token');

    if (result != null) {
      var result2 = jsonDecode(result);
      user = result2;
    }

    if (token != null) {
      var token2 = jsonDecode(token);
      this.token = token2;
    }

    //    print('done done');
  }

  void notifyToast({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.CENTER);
  }

  void notifyToastDanger({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white);
  }

  void notifyToastSuccess({context, message}) {
    Toast.show(message, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  Future<String> loadInterestJsonFile(String assetsPath) async {
    return rootBundle.loadString(assetsPath);
  }

  Future<http.Response> post(url, payload) async {
    var response = await http.post(endpoint + url, body: payload, headers: {
      "accept": "application/json",
    });

    return response;
  }

  Future<http.Response> postURL(url, payload) async {
    var response = await http.post(url, body: payload, headers: {
      "accept": "application/json",
    });

    return response;
  }

  Future<http.Response> postAuth(url, payload) async {
    var response = await http.post(url, body: payload, headers: {
      "accept": "application/json",
      'Authorization': 'Bearer ' + token
    });

    // if (kDebugMode) {
    //   print(response.statusCode);
    // }
    // if (response.statusCode == 401) {
    //   // Navigator.push(context,
    //   //     new MaterialPageRoute(builder: (context) => new LoginPage()));
    // }
    // if (response.statusCode == 422) {
    //   Map<String, dynamic> resp = jsonDecode(response.body);
    //   Map<String, dynamic> errors = resp['errors'];
    //   notifyToastDanger(
    //       context: context, message: errors.values.toList()[0][0]);
    // }
    return response;
  }

  Future<http.Response> get(url, {context}) async {
    var response = await http.get(url, headers: {"accept": "application/json"});
    if (response.statusCode == 401 && context != null) {
      // Navigator.push(context,
      //     new MaterialPageRoute(builder: (context) => new LoginPage()));
    }

    return response;
  }

  String formatDate(date) {
    return date.toString().split(' ')[0];
  }

  String formatTime(time) {
    return time.toString().split(':')[0] + ':' + time.toString().split(':')[1];
  }
}
