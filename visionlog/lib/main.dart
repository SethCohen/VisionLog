import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/pages/home_page.dart';
import 'package:visionlog/pages/manage_page.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:visionlog/providers/google_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:visionlog/widgets/dream.dart';
import 'package:visionlog/widgets/edit_dream.dart';
import 'package:visionlog/pages/support_page.dart';

import 'widgets/add_dream.dart';
import 'widgets/dream_entree.dart';

// TODO fix chart wrapping (legend gets cut off on some phones)
// TODO update packages and symbols
// TODO optimize code
// TODO comment stuff

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Documents())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  static const String title = 'MainPage';

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xFF000000),
          disabledColor: Colors.white70,
          textTheme: const TextTheme(
            subtitle1: TextStyle(color: Colors.white70),
            caption: TextStyle(color: Colors.white70),
            bodyText2: TextStyle(color: Colors.white70),
            headline4: TextStyle(color: Colors.white70),
          ),
          cardTheme: const CardTheme(
            color: Color(0xFF121219),
            shadowColor: Colors.white38,
            elevation: 3,
          ),
          popupMenuTheme: const PopupMenuThemeData(
              color: Color(0xFF15151C),
              textStyle: TextStyle(color: Colors.white70)),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/addDream': (BuildContext context) => const AddDream(),
          '/dreamEntree': (BuildContext context) => const DreamEntree(),
          '/supportMe': (BuildContext context) => const SupportPage(),
          '/manageAccount': (BuildContext context) => const ManagePage(),
        },
        onGenerateRoute: (RouteSettings settings) {
          debugPrint('build route for ${settings.name}');
          var routes = <String, WidgetBuilder>{
            "/editDream": (ctx) => EditDream(settings.arguments as Dream),
          };
          WidgetBuilder? builder = routes[settings.name];
          return MaterialPageRoute(builder: (ctx) => builder!(ctx));
        },
      ));
}