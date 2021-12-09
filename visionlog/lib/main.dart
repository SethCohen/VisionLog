import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/pages/home_page.dart';
import 'package:visionlog/provider/dream_documents.dart';
import 'package:visionlog/provider/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visionlog/widgets/edit_dream.dart';

import 'widgets/add_dream.dart';
import 'widgets/dream_entree.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Documents())
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  static final String title = 'MainPage';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xFF15151C),
          disabledColor: Colors.white70,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.white70),
            caption: TextStyle(color: Colors.white70),
            bodyText2: TextStyle(color: Colors.white70),
            headline4: TextStyle(color: Colors.white70),
          ),
          cardTheme: CardTheme(
            color: const Color(0xFF121219),
            shadowColor: Colors.white38,
            elevation: 3,
          ),
          popupMenuTheme: PopupMenuThemeData(
            color: const Color(0xFF15151C),
            textStyle: TextStyle(color: Colors.white70)
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
        routes: <String, WidgetBuilder>{
          '/addDream': (BuildContext context) => AddDream(),
          '/editDream': (BuildContext context) => EditDream(),
          '/dreamEntree': (BuildContext context) => DreamEntree(),
        },
      ));
}
