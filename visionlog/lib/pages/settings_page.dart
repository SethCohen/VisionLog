import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visionlog/widgets/sign_out.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final ScrollController _controllerOne = ScrollController();

  final user = FirebaseAuth.instance.currentUser!;
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [SignOut()],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 8.0, 8.0, 8.0),
        child: Scrollbar(
          controller: _controllerOne,
          child: ListView(
            controller: _controllerOne,
            children: [
              Text('General',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null, // TODO finish export database
                  child: Text(
                    'Export database',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null, // TODO finish theme editor
                  child: Text(
                    'Appearance',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null, // TODO finish account manager
                  child: Text(
                    'Manage Account',
                    style: TextStyle(color: Colors.white70),
                  )),
              Text('About',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchPrivacyPolicyURL,
                  // TODO change privacy policy url to personal website
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchGithubURL,
                  child: Text(
                    'Source Code',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchReviewURL,
                  child: Text(
                    'Rate This App',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null, // TODO changelog
                  child: Text(
                    'Recent Changes',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null,
                  child: Text(
                    'Version: ${_packageInfo.version}',
                    style: TextStyle(color: Colors.white70),
                  )),
              Text('Report Issues',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchReportIssueGithubURL,
                  child: Text(
                    'Report An Issue Via Github',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchSendEmail,
                  child: Text(
                    'Report An Issue Via Email',
                    style: TextStyle(color: Colors.white70),
                  )),
              Text('Other',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null, // TODO finish IAP
                  child: Text(
                    'Support Me',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchPersonalSiteURL,
                  child: Text(
                    'Visit My Website',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: Colors.grey.shade900,
                          title: const Text('Hi, I\'m Seth! 🍵',
                              style: TextStyle(color: Colors.white)),
                          content: SizedBox(
                            height: 350,
                            child: SingleChildScrollView(
                              child: RichText(
                                  textScaleFactor: 1.15,
                                  text: TextSpan(
                                      style: TextStyle(color: Colors.white),
                                      text:
                                          "I'm a freelancer and hobbyist who's passionate towards creating various apps, software, digital art, and graphic designs. I created this app for my own personal use to help me lucid dream better and just because I thought it'd be nice to record my dreams.\n\nAlong the way I thought it'd be nice to share my app with others, so here we are. I'll always try to focus on efficiency and simplicity so hopefully this app never becomes slow. Nor will there ever be ads.\n\nIf you'd like to see more of my work or contact me for work - as I am a freelancer - you can check out my personal website from the ",
                                      children: [
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            text: "Visit My Website"),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            text:
                                                " button.\n\nOr if you'd like to show some support, you can "),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic),
                                            text: "buy me a "),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                fontStyle: FontStyle.italic),
                                            text: "coffee"),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic),
                                            text: " tea"),
                                        TextSpan(
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                            text: " from the "),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                            text: "Support Me"),
                                        TextSpan(
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.normal),
                                            text:
                                                " button. I'd very much appreciate it! This app is completely free so I don't really make any money from it.\n\nAnyways, hope you enjoy this app and have great dreams!\nThank you for installing it. 🙂")
                                      ])),
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'OK'),
                              child: const Text('OK',
                                  style: TextStyle(color: Colors.white)),
                              style: ButtonStyle(
                                  splashFactory: NoSplash.splashFactory),
                            ),
                          ],
                        ),
                      ), //
                  child: Text(
                    'About Me',
                    style: TextStyle(color: Colors.white70),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _launchPersonalSiteURL() async {
    const url = 'https://sethdev.ca/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchGithubURL() async {
    const url = 'https://github.com/SethCohen/VisionLog';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchReviewURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=seth.cohen.visionlog&reviewId=0';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchReportIssueGithubURL() async {
    const url = 'https://github.com/SethCohen/VisionLog/issues';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchSendEmail() async {
    const url =
        'mailto:sethcohen.dev@gmail.com?subject=VisionLog Issue&body=Please answer each field as best as possible, blank answers are fine though. Thank you.\n______________\n\nPhone Model: \n\nPhone OS Version: \n\nDescription of issue: \n\nThe last thing you were doing before the issue happened: \n';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _launchPrivacyPolicyURL() async {
    const url = 'https://sites.google.com/view/sethcohen/home';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
