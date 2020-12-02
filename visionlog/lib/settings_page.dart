import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: _launchGithubURL, // TODO finish export database
                  child: Text(
                    'Export database',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: _launchGithubURL, // TODO finish export old dreams
                  child: Text(
                    'Export old dreams',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),

              TextButton(
                  onPressed: null, // TODO import
                  child: Text(
                    'Import',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchReportIssueGithubURL,
                  child: Text(
                    'Report an issue via Github',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: _launchReportIssueGmailURL,
                  child: Text(
                    'Report an issue via Gmail',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchGithubURL,
                  child: Text(
                    'Github',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: _launchReviewURL,
                  child: Text(
                    'Rate This App',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: _launchPrivacyPolicyURL,
                  child: Text(
                    'Privacy Policy',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: null, // TODO changelog
                  child: Text(
                    'Changelog',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: null, // TODO roadmap
                  child: Text(
                    'Roadmap',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchPersonalSiteURL,
                  child: Text(
                    'My Website',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              TextButton(
                  onPressed: _launchSupportURL, // TODO finish buy a coffee
                  child: Text(
                    'Buy Me a Coffee',
                    textScaleFactor: 1.25,
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

  _launchSupportURL() async {
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

  _launchReportIssueGmailURL() async {
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
