import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:visionlog/widgets/logged_in.dart';
import 'package:visionlog/widgets/sign_in.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return LoggedIn();
            } else if (snapshot.hasError) {
              return Center(child: Text('Something went wrong!'));
            } else {
              return SignIn();
            }
          }));
}
