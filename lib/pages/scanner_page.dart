import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/rendering.dart';
import 'package:picknmelt/pages/searchresult_page.dart';
import 'package:provider/provider.dart';
import 'package:picknmelt/store/index.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:picknmelt/widgets/custom_searchbtn.dart';
// page
import 'package:picknmelt/pages/login_page.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key key}) : super(key: key);

  @override
  _ScannerPage createState() => _ScannerPage();
}

class _ScannerPage extends State<ScannerPage> {
  AppState state;
  PanelController _pc;
  TextEditingController _searchController;
  final double _initFabHeight = 50.0;
  double _fabHeight = 0;
  double _panelHeightOpen = 0.0;
  final double _panelHeightClosed = 0.0;
  double appHeight = 0.0;
  double _delta = 0.0;
  bool _show = true;

  Barcode result;
  QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool _flashToggle;

  @override
  void initState() {
    super.initState();
    _customInit();
    setState(() {});
  }

  void _customInit() async {
    state = Provider.of<AppState>(context, listen: false);
    _pc = PanelController();
    _fabHeight = _initFabHeight;
    appHeight = AppBar().preferredSize.height;
    _delta = 50;
    _flashToggle = false;
    final status = await Permission.camera.request();
    if (status == PermissionStatus.granted) {
      print('Permission granted');
    } else if (status == PermissionStatus.denied) {
      print(
          'Permission denied. Show a dialog and again ask for the permission');
    } else if (status == PermissionStatus.permanentlyDenied) {
      print('Take the user to the settings page.');
      await openAppSettings();
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void showAppBar() async {
    await controller?.resumeCamera();
    setState(() {
      _show = true;
      _delta = 50;
    });
  }

  void hideAppBar() async {
    await controller?.pauseCamera();
    setState(() {
      _show = false;
      _delta = 20;
    });
  }

  void logOut() async {
    await state.sp.clear();
    state.user = null;
    state.token = null;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
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

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    }
    controller.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    Color backColor = Colors.white;
    _panelHeightOpen = MediaQuery.of(context).size.height * .35;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: backColor,
      appBar: _show
          ? AppBar(
              leading: IconButton(
                icon: _flashToggle
                    ? const Icon(Icons.flash_on_sharp)
                    : const Icon(Icons.flash_off_sharp),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {
                    _flashToggle = !_flashToggle;
                  });
                },
                color: Colors.white,
              ),
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
        color: Theme.of(context).primaryColor,
        panelBuilder: (sc) => _panel(sc),
        body: _body(),
        onPanelSlide: (double pos) {
          setState(() {
            _fabHeight =
                pos * (_panelHeightOpen - _panelHeightClosed) + _initFabHeight;
            if (pos == 0.0) {
              _show = true;
            }
          });
        },
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
    );
  }

  Widget _body() {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height - appHeight - _delta,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(child: _buildQrView(context)),
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
            children: <Widget>[
              Text(
                state.user['username'],
                style: const TextStyle(
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
                  logOut();
                },
                child: Row(
                  children: const [
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
                onTap: () {},
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

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      state.sku = scanData.code;
      controller.pauseCamera();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SerachResultPage()));
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No Permission.')),
      );
    }
  }
}
