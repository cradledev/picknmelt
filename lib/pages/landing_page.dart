import 'package:flutter/material.dart';
import 'package:picknmelt/pages/login_page.dart';
import 'package:picknmelt/store/index.dart';
import 'package:provider/provider.dart';

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
    state = Provider.of<AppState>(context, listen: false);
    Future.delayed(const Duration(seconds: 2), () {
      if (state.user == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      } else {
        // print('options');
        Navigator.of(context).pop();
      }
    });
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
                      backgroundColor: Colors.lightBlue,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
