import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = _googleSignIn.currentUser;

    return Scaffold(
      appBar: AppBar(
          title: Text(
              'Logged ' + (user == null ? 'out' : 'in'))),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                child: Text('Sign In'),
                onPressed: user != null ? null : () async {
                  await _googleSignIn.signIn();
                  setState(() {});
                }),
            ElevatedButton(
                child: Text('Sign Out'),
                onPressed: user == null ? null : () async {
                  await _googleSignIn.signOut();
                  setState(() {});
                }),
          ],
        ),
      ),
    );
  }
}