import 'package:cue/screen/Home/mainPage.dart';
import 'package:cue/screen/login/login.dart';
import 'package:cue/services/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData _cueTheme = _buildCueTheme();

ThemeData _buildCueTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    accentColor: cueOrange,
    primaryColor: cueSurfaceWhite,
    buttonTheme: base.buttonTheme.copyWith(
      buttonColor: cueOrange,
    ),
    buttonBarTheme: base.buttonBarTheme.copyWith(
      buttonTextTheme: ButtonTextTheme.accent,
    ),
    scaffoldBackgroundColor: cueBackgroundWhite,
    cardColor: cueBackgroundWhite,
    textSelectionColor: cueOrange,
    errorColor: cueErrorRed,
    textTheme: _buildCueTextTheme(base.textTheme),
    primaryTextTheme: _buildCueTextTheme(base.primaryTextTheme),
    accentTextTheme: _buildCueTextTheme(base.accentTextTheme),
  );
}

TextTheme _buildCueTextTheme(TextTheme base) {
  return base.copyWith(
      headline1: base.headline1.copyWith(
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        fontSize: 60.0,
        color: Color(0xFFFF9700),
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      headline2: base.headline2.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 30,
        letterSpacing: 1.0,
        color: Color(0xFFFF9700),
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
        color: Color(0xFFFF9700),
        fontFamily: GoogleFonts.notoSans().fontFamily,
      ),
      bodyText1: base.bodyText1
          .copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 16.0,
            color: Color(0xFFFF9700),
          )
          .apply(
            fontFamily: GoogleFonts.notoSans().fontFamily,
            color: Colors.black,
          ));
}

class CueApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cue!',
      theme: _cueTheme,
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      onGenerateRoute: _getRoute,
    );
  }
}

Route<dynamic> _getRoute(RouteSettings settings) {
  if (settings.name != '/login') {
    return null;
  }

  return MaterialPageRoute<void>(
    settings: settings,
    builder: (BuildContext context) => SplashPage(),
    fullscreenDialog: true,
  );
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//         Duration(seconds: 2),
//         () => Navigator.pushReplacement(
//             context, MaterialPageRoute(builder: (context) => LogIn())));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.orange, child: Image.asset('images/splash.png'));
//   }
// }

// SHARED PREFERENCE

//Future<void> main() async {
//  SharedPreferences prefs = await SharedPreferences.getInstance();
//  var token = prefs.getString('token');
//  print(token);
//  runApp(MaterialApp(home: token == null ? LogIn() : MyHomePage()));
//}
