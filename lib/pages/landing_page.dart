import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:picknmelt/pages/login_page.dart';
import 'package:picknmelt/store/index.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:picknmelt/pages/searchresult_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key key}) : super(key: key);

  @override
  _LandingPage createState() => _LandingPage();
}

class _LandingPage extends State<LandingPage> {
  AppState state;
  @override
  void initState() {
    super.initState();
    _initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (state.user == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        // print('options');
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SerachResultPage()));
      }
    });
  }

  void _initState() async {
    state = Provider.of<AppState>(context, listen: false);
    state.sp = await SharedPreferences.getInstance();
    String _temp = state.sp.getString('user') ?? "";
    String _tempToken = state.sp.getString('token') ?? "";
    if (_temp.isNotEmpty && _tempToken.isNotEmpty) {
      Map _tempUser = jsonDecode(_temp);
      // print(_tempUser);
      if (_tempUser.isNotEmpty) {
        state.user = _tempUser;
        state.token = _tempToken;
      } else {
        state.user = null;
      }
    }

    // print(state.user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color.fromRGBO(255, 126, 0, 1.0),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.zero,
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    padding: const EdgeInsets.only(left: 0.1, right: 0.1),
                    child: Image.asset(
                      "assets/images/mark.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    width: MediaQuery.of(context).size.width,
                    // height: 50,
                    child: const LinearProgressIndicator(
                      minHeight: 2,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 99, 57, 16)),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
