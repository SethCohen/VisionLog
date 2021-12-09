import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/provider/google_sign_in.dart';

class SignOut extends StatelessWidget {
  SignOut({Key? key}) : super(key: key);
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: CircleAvatar(backgroundImage: NetworkImage(user.photoURL!)),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!)),
                Text(user.displayName!, style: TextStyle(fontWeight: FontWeight.bold),)
              ],
            ),
            enabled: false,
          ),
          PopupMenuItem(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Sign Out", style: TextStyle(fontWeight: FontWeight.bold)), Icon(Icons.logout)],
            ),
            onTap: (){
              final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogout();
            },
          ),
        ]);

  }
}