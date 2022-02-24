import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:picknmelt/store/index.dart';
import 'package:picknmelt/widgets/custom_formfield.dart';
import 'package:picknmelt/widgets/custom_button.dart';
import 'package:picknmelt/widgets/custom_searchfield.dart';
import 'package:picknmelt/widgets/custom_searchbtn.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  AppState state;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _searchController;
  PanelController _pc;
  final double _initFabHeight = 50.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0;
  double _panelHeightClosed = 50.0;
  @override
  void initState() {
    super.initState();
    state = Provider.of<AppState>(context, listen: false);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _searchController = TextEditingController();
    _pc = PanelController();
    _fabHeight = _initFabHeight;
    setState(() {});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color backColor = Colors.white;
    _panelHeightOpen = MediaQuery.of(context).size.height * .35;
    TextStyle headerText = Theme.of(context).textTheme.headline4;
    return WillPopScope(
      onWillPop: () {},
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: backColor,
        // appBar: AppBar(
        //   leading: Container(),
        //   title: GestureDetector(
        //     onTap: () {
        //       Navigator.push(context,
        //           MaterialPageRoute(builder: (context) => const TopDrawer()));
        //     },
        //     child: Image.asset("assets/images/top_draw_icon.png",
        //         fit: BoxFit.contain),
        //   ),
        //   centerTitle: true,
        //   backgroundColor: Theme.of(context).primaryColor,
        // ),
        body: SlidingUpPanel(
          slideDirection: SlideDirection.DOWN,
          maxHeight: _panelHeightOpen,
          minHeight: _panelHeightClosed,
          parallaxEnabled: true,
          parallaxOffset: 0.1,
          controller: _pc,
          isDraggable: false,
          padding: const EdgeInsets.only(
            bottom: 20,
          ),
          color: Theme.of(context).primaryColor,
          panelBuilder: (sc) => _panel(sc),
          body: _body(),
          onPanelSlide: (double pos) => setState(() {
            _fabHeight =
                pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
          }),
          collapsed: GestureDetector(
            onTap: () {
              _pc.open();
            },
            child: Center(
              child: Image.asset(
                "assets/images/top_draw_icon.png",
                fit: BoxFit.contain,
                width: 15,
                height: 15,
              ),
            ),
          ),
          header: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.zero,
            margin: EdgeInsets.zero,
            child: GestureDetector(
              onTap: () {
                _pc.close();
              },
              child: Center(
                child: Image.asset(
                  "assets/images/top_draw_icon.png",
                  fit: BoxFit.contain,
                  width: 15,
                  height: 15,
                ),
              ),
            ),
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
          height: MediaQuery.of(context).size.height - 80,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 100.0,
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
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
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 16,
                                    horizontal: 24,
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
                                  onTap: () {},
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
                "Explore Pittsburgh",
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
            children: const <Widget>[
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
                // child: SerachFormField(
                //   headingText: "KSU",
                //   hintText: "SKU",
                //   obsecureText: true,
                //   controller: _searchController,
                //   maxLines: 1,
                //   textInputAction: TextInputAction.done,
                //   textInputType: TextInputType.text,
                // ),
                child: TextField(
                  autofocus: false,
                  style: const TextStyle(color: Colors.white70),
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
                    onTap: () {},
                    text: 'Search',
                  ))
            ],
          )
        ],
      ),
    );
  }
}
