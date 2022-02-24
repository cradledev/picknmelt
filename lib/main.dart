import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:picknmelt/store/index.dart';
import 'package:picknmelt/pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: AppState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //   systemNavigationBarColor: Colors.grey[200].withOpacity(0),
    //   systemNavigationBarIconBrightness: Brightness.dark,
    //   systemNavigationBarDividerColor: Colors.black.withOpacity(0),
    // ));
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        // primaryColor: Color.fromRGBO(88, 51, 254, 1.0),
        primaryColor: const Color.fromRGBO(255, 126, 0, 1.0),
        backgroundColor: Colors.white,
        // Define the default font family.
        fontFamily: 'OpenSans',
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.grey[100]),
        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 72.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 126, 0, 1.0),
              fontFamily: 'OpenSans',
            ),
            headline6: TextStyle(
              fontSize: 36.0,
              fontStyle: FontStyle.italic,
            ),
            headline5: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
              color: Color.fromRGBO(255, 126, 0, 1.0),
              fontFamily: 'OpenSans',
            ),
            headline4: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 126, 0, 1.0),
              fontFamily: 'OpenSans',
            ),
            bodyText2: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(255, 126, 0, 1.0),
              fontFamily: 'OpenSans',
            ),
            bodyText1: TextStyle(
              fontSize: 18.0,
              color: Color.fromRGBO(255, 126, 0, 1.0),
              fontFamily: 'OpenSans',
            ),
            subtitle1: TextStyle(
              fontSize: 18.0,
              color: Colors.white,
              fontFamily: 'HandOfSean',
            )),
      ),
      home: const LandingPage(),
    );
  }
}
