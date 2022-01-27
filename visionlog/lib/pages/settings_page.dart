import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visionlog/providers/dream_documents_provider.dart';
import 'package:visionlog/widgets/dream.dart';
import 'package:visionlog/widgets/sign_out.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:external_path/external_path.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

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
        title: const Text('Settings'),
        actions: [SignOut()],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(48.0, 8.0, 8.0, 8.0),
        child: Scrollbar(
          controller: _controllerOne,
          child: ListView(
            controller: _controllerOne,
            children: [
              const Text('General',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () {
                    _exportDatabase(context);
                  },
                  child: const Text(
                    'Export database',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () => _showManageAccountPage(context),
                  child: const Text(
                    'Manage Account',
                    style: TextStyle(color: Colors.white70),
                  )),
              const Text('About',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchPrivacyPolicyURL,
                  child: const Text(
                    'Privacy Policy',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchGithubURL,
                  child: const Text(
                    'Source Code',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchReviewURL,
                  child: const Text(
                    'Rate This App',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () => _showRecentChangesAlert(),
                  child: const Text(
                    'Recent Changes',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: null,
                  child: Text(
                    'Version: ${_packageInfo.version}',
                    style: const TextStyle(color: Colors.white70),
                  )),
              const Text('Report Issues',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchReportIssueGithubURL,
                  child: const Text(
                    'Report An Issue Via Github',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchSendEmail,
                  child: const Text(
                    'Report An Issue Via Email',
                    style: TextStyle(color: Colors.white70),
                  )),
              const Text('Other',
                  textScaleFactor: 1.05,
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold)),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () => _showSupportPage(),
                  child: const Text(
                    'Support Me',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: _launchPersonalSiteURL,
                  child: const Text(
                    'Visit My Website',
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  style: const ButtonStyle(alignment: Alignment.centerLeft),
                  onPressed: () => _showAboutMeAlert(), //
                  child: const Text(
                    'About Me',
                    style: TextStyle(color: Colors.white70),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _showRecentChangesAlert() {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              backgroundColor: Colors.grey.shade900,
              title: const Text('Recent Changes',
                  style: TextStyle(color: Colors.white)),
              content: SizedBox(
                height: 350,
                child: SingleChildScrollView(
                  child: RichText(
                      textScaleFactor: 1.15,
                      text: TextSpan(
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                          text: "What's new in v${_packageInfo.version}\n",
                          children: const [
                            TextSpan(
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal),
                                text:
                                    "\nComplete app rewrite from plain old Java to the Flutter framework. This update hopes to bring a more efficient and cleaner design to the app.\n- Revamped entire overall appearance of the app.\n- Added more dream types (e.g. continuous dream for sequel dreams, recurring dreams that repeat, etc)\n- Added being able to record the feel of a dream (e.g. terrible, fantastic, etc)\n- Added different kinds of graphs (Feel pie chart, Type pie chart, and a Numerical counts chart)\n- Added more date ranges for charts.\n- Added dream titles\n- App now relies entirely on a cloud database for cloud functionality (Powered by Google Firebase). No matter what phone, you should be able to access your dream journal from your gmail account. Also supports offline functionality.\n- Added account management\n- Added old dream recovery from old app version (Accessible from Dream Page)"),
                          ])),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'OK'),
                  child:
                      const Text('OK', style: TextStyle(color: Colors.white)),
                  style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                ),
              ],
            ));
  }

  _showAboutMeAlert() {
    showDialog<String>(
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
                      text: const TextSpan(
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
                                    decoration: TextDecoration.lineThrough,
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
                  child:
                      const Text('OK', style: TextStyle(color: Colors.white)),
                  style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
                ),
              ],
            ));
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
    const url = 'https://sethdev.ca/portfolio/programming/visionlog/privacy-policy/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _exportDatabase(BuildContext context) async {
    var docs = Provider.of<Documents>(context, listen: false).documents;
    var dreams = docs!.map((DocumentSnapshot document) => Dream.fromMap(
        document.data() as Map<String, dynamic>,
        reference: document.reference)).toList();

    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add('title');
    row.add('message');
    row.add('feel');
    row.add('datetime');
    row.add('is_lucid');
    row.add('is_nightmare');
    row.add('is_recurring');
    row.add('is_continuous');
    rows.add(row);
    for (var dream in dreams) {
      List<dynamic> row = [];
      row.add(dream.title);
      row.add(dream.message);
      row.add(dream.feel);
      row.add(dream.datetime);
      row.add(dream.isLucid);
      row.add(dream.isNightmare);
      row.add(dream.isRecurring);
      row.add(dream.isContinuous);
      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    String? dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
    String file = dir;

    File f = File("$file/VisionLog-${DateFormat.yMd().format(DateTime.now()).replaceAll('/', '-')}.csv");
    debugPrint('Saved to $f');

    f.writeAsString(csv);

    final snackBar = SnackBar(
      content: Text('Saved To $f'),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _showSupportPage() {
    Navigator.pushNamed(context, '/supportMe');
  }

  _showManageAccountPage(context) {
    Navigator.pushNamed(context, '/manageAccount');
  }
}