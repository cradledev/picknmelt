import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:picknmelt/store/index.dart';
import 'package:picknmelt/widgets/custom_formfield.dart';
import 'package:picknmelt/widgets/custom_button.dart';
// import 'package:picknmelt/widgets/custom_searchfield.dart';
import 'package:picknmelt/widgets/custom_searchbtn.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import 'package:picknmelt/pages/searchresult_page.dart';
import 'package:picknmelt/pages/scanner_page.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  AppState state;
  Map user;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _searchController;
  PanelController _pc;
  final double _initFabHeight = 50.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0.0;
  double _panelHeightClosed = 0.0;
  double appHeight = 0.0;
  double _delta = 0.0;
  bool _show = true;
  bool _rememberMeFlag = false;
  @override
  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _searchController = TextEditingController();
    _pc = PanelController();
    _fabHeight = _initFabHeight;
    appHeight = AppBar().preferredSize.height;
    _delta = 50;
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void showAppBar() {
    setState(() {
      _show = true;
      _delta = 50;
    });
  }

  void hideAppBar() {
    setState(() {
      _show = false;
      _delta = 20;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text(
              'Are you sure?',
              style: TextStyle(
                  color: Colors.black, fontSize: 16, fontFamily: "HandOfSean"),
            ),
            content: const Text(
              'Do you want to exit the App',
              style: TextStyle(color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              TextButton(
                onPressed: () => exit(0),
                child: const Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    Color backColor = Colors.white;
    _panelHeightOpen = MediaQuery.of(context).size.height * .35;
    TextStyle headerText = Theme.of(context).textTheme.headline4;
    return WillPopScope(
      onWillPop: () async {
        bool result = await _onWillPop();
        return result;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backColor,
        appBar: _show
            ? AppBar(
                leading: Container(),
                title: GestureDetector(
                  onTap: () {
                    _pc.open();
                    hideAppBar();
                  },
                  child: Image.asset(
                    "assets/images/top_draw_icon.png",
                    fit: BoxFit.contain,
                    width: 25,
                    height: 25,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).primaryColor,
              )
            : PreferredSize(
                child: Container(),
                preferredSize: const Size(0.0, 0.0),
              ),
        body: SlidingUpPanel(
          slideDirection: SlideDirection.DOWN,
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: 0.1,
          controller: _pc,
          isDraggable: false,
          // padding: const EdgeInsets.only(
          //   bottom: 20,
          // ),
          color: Theme.of(context).primaryColor,
          panelBuilder: (sc) => _panel(sc),
          body: _body(),
          onPanelSlide: (double pos) {
            setState(() {
              _fabHeight = pos * (_panelHeightOpen - _panelHeightClosed) +
                  _initFabHeight;
              if (pos == 0.0) {
                _show = true;
              }
            });
          },
          // collapsed: GestureDetector(
          //   onTap: () {
          //     _pc.open();
          //   },
          //   child: Center(
          //     child: Image.asset(
          //       "assets/images/top_draw_icon.png",
          //       fit: BoxFit.contain,
          //       width: 20,
          //       height: 20,
          //     ),
          //   ),
          // ),
          header: (_pc.isAttached)
              ? (_pc.isPanelOpen)
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(bottom: 15),
                      margin: EdgeInsets.zero,
                      child: GestureDetector(
                        onTap: () {
                          _pc.close();
                          showAppBar();
                        },
                        child: Center(
                          child: Image.asset(
                            "assets/images/top_up_icon.png",
                            fit: BoxFit.contain,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(
                      height: 0,
                    )
              : const SizedBox(
                  height: 0,
                ),
        ),
      ),
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          height: MediaQuery.of(context).size.height - appHeight - _delta,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 20.0,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.only(left: 0.1, right: 0.1),
                margin: const EdgeInsets.only(bottom: 10),
                child: Image.asset(
                  "assets/images/mark.png",
                  fit: BoxFit.contain,
                ),
              ),
              const Text(
                'Stock Management Application',
                style: TextStyle(fontSize: 17),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  width: MediaQuery.of(context).size.width * 0.8,
                  // height: 50,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 24,
                            ),
                            CustomFormField(
                              headingText: "Username",
                              hintText: "Username",
                              obsecureText: false,
                              suffixIcon: const SizedBox(),
                              controller: _emailController,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomFormField(
                              headingText: "Password",
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              hintText: "Password",
                              obsecureText: true,
                              controller: _passwordController,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  onChanged: (value) {
                                    setState(() {
                                      _rememberMeFlag = !_rememberMeFlag;
                                    });
                                  },
                                  value: _rememberMeFlag,
                                  activeColor: Theme.of(context).primaryColor,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 5,
                                  ),
                                  child: InkWell(
                                    onTap: () {},
                                    child: Text(
                                      "Remember me",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.7),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                AuthButton(
                                  onTap: () async {
                                    await login();
                                  },
                                  text: 'Sign In',
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 50,
                        color: Colors.blue.withOpacity(0),
                        alignment: Alignment.center,
                        child:
                            const Text("Copyright 2022 - All rights reserved"),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _panel(ScrollController sc) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 0,
        ),
        controller: sc,
        children: <Widget>[
          const SizedBox(
            height: 24.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                "Non Authentication",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              Icon(
                Icons.logout,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Sign out",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  if (state.user == null) {
                    state.notifyToastDanger(
                        context: context, message: "User must sign in.");
                  } else {
                    _pc.close();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScannerPage()));
                  }
                },
                child: Row(
                  children: const [
                    Icon(
                      Icons.scanner,
                      color: Colors.white,
                      size: 24.0,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Scanner",
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[
              Icon(
                Icons.search_rounded,
                color: Colors.white,
                size: 24.0,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                "Search by SKU",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  autofocus: false,
                  style: const TextStyle(color: Colors.black),
                  controller: _searchController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'SKU',
                    hintStyle: TextStyle(
                      fontFamily: "Oepn-Sans",
                      fontSize: 15,
                    ),
                    contentPadding:
                        EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: SearchButton(
                    onTap: () {
                      search();
                    },
                    text: 'Search',
                  ))
            ],
          )
        ],
      ),
    );
  }

  Future<void> login() async {
    if (_emailController.text.trim().isNotEmpty &&
        _passwordController.text.trim().isNotEmpty) {
      state.sp = await SharedPreferences.getInstance();
      String _username = _emailController.text;
      String _password = _passwordController.text;

      user = {'username': _username, 'password': _password};
      String _url = "https://appdev01.picknmelt.com/wp-json/jwt-auth/v1/token";
      // String _url = "https://95.217.114.43/wp-json/jwt-auth/v1/token";
      print("1111111111111111111");
      state.postURL(Uri.parse(_url), user).then((data) {
        var body = jsonDecode(data.body);
        // print(body);
        // print(data);
        // print(data.statusCode);
        if (data.statusCode == 422) {
          Map<String, dynamic> response = jsonDecode(data.body);
          Map<String, dynamic> errors = response['errors'];
          state.notifyToastDanger(
              context: context, message: errors.values.toList()[0][0]);
        } else if (data.statusCode == 200) {
          var data = body['data'];
          if (_rememberMeFlag) {
            state.sp.setString('user', jsonEncode(user));
            state.sp.setString('token', data['token']);
          }
          state.user = user;
          state.token = data['token'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SerachResultPage(),
            ),
          );
        } else if (data.statusCode == 403) {
          state.notifyToastDanger(context: context, message: body['message']);
        } else {
          state.notifyToastDanger(
              context: context, message: "Error occured while authenticating");
        }
      }).catchError((error) {
        print(error);
      });
      print("2222222222222222222222222");
      // if (_rememberMeFlag) {
      //       state.sp.setString('user', jsonEncode(user));
      //       // state.sp.setString('token', data['token']);
      //     }
      //     state.user = user;
      //     // state.token = data['token'];
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => const SerachResultPage(),
      //       ),
      //     );
    } else {
      state.notifyToastDanger(
          context: context, message: "Username or Password must be not Empty.");
    }
  }

  void search() async {
    if (state.user == null) {
      state.notifyToastDanger(context: context, message: "User must sign in.");
    } else {
      _pc.close();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SerachResultPage(),
        ),
      );
    }
    // _pc.close();
  }
}
