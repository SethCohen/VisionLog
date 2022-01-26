import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:visionlog/providers/google_provider.dart';

class ManagePage extends StatefulWidget {
  const ManagePage({Key? key}) : super(key: key);

  @override
  _ManagePageState createState() => _ManagePageState();
}

class _ManagePageState extends State<ManagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 8.0, 8.0, 8.0),
        child: ListView(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white70,
                alignment: Alignment.centerLeft,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: _signOut,
              child: const Text(
                'Sign Out',
                textScaleFactor: 1.05,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white70,
                alignment: Alignment.centerLeft,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: _deleteAccount,
              child: const Text(
                'Delete Account',
                textScaleFactor: 1.05,
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                primary: Colors.white70,
                alignment: Alignment.centerLeft,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: _resetJournal,
              child: const Text(
                'Reset/Clear Journal',
                textScaleFactor: 1.05,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _signOut() {
    final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
    provider.googleLogout();
    Navigator.pop(context);
  }

  void _deleteAccount() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: const Text('Are You Sure?',
                  style: TextStyle(color: Colors.white)),
              content: const Text(
                  'You\'re trying to delete your account.\nYour account and data will be deleted immediately. This action is not reversible.\nPlease hold YES to confirm.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                ),
                TextButton(
                  onLongPress: () {
                    FirebaseAuth.instance.currentUser!.delete();
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogout();
                    Navigator.pop(context);

                    const snackBar = SnackBar(
                      content: Text('Account Deleted'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pop(context);
                  },
                  onPressed: () {},
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.white)),
                ),
              ],
            ));
  }

  void _resetJournal() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: const Text('Are You Sure?',
                  style: TextStyle(color: Colors.white)),
              content: const Text(
                  'You\'re trying to clear all your dreams from your dream journal.\nThis action is not reversible.\nPlease hold YES to confirm.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel',
                      style: TextStyle(color: Colors.white)),
                  style:
                      const ButtonStyle(splashFactory: NoSplash.splashFactory),
                ),
                TextButton(
                  onLongPress: () {
                    for (DocumentSnapshot document
                        in Provider.of<Documents>(context, listen: false)
                            .documents!) {
                      document.reference
                          .delete()
                          .then((value) => debugPrint('Success!'))
                          .catchError((e) => debugPrint(e));
                    }

                    const snackBar = SnackBar(
                      content: Text('Journal Reset!'),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);

                    Navigator.pop(context);
                  },
                  onPressed: () {},
                  child:
                      const Text('Yes', style: TextStyle(color: Colors.white)),
                ),
              ],
            ));
  }
}