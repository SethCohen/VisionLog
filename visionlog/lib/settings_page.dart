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
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: _launchGithubURL,
                  child: Text(
                    'Export database',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchGithubURL,
                  child: Text(
                    'Export old dreams',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchReportIssueGithubURL,
                  child: Text(
                    'Report an issue with Github',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchReportIssueGmailURL,
                  child: Text(
                    'Report an issue with Gmail',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchSupportURL,
                  child: Text(
                    'Buy me a coffee',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchReviewURL,
                  child: Text(
                    'Rate this app',
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
              Divider(
                color: Colors.white70,
              ),
              TextButton(
                  onPressed: _launchPrivacyPolicyURL,
                  child: Text(
                    'Privacy Policy',
                    textScaleFactor: 1.25,
                    style: TextStyle(color: Colors.white70),
                  )),

            ],
          ),
        ),
      ),
    );
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
    const url = 'mailto:sethcohen.dev@gmail.com?subject=VisionLog Issue';
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
