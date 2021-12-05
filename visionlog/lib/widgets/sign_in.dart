import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visionlog/provider/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignIn extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          SvgPicture.asset(
            'assets/vision_log_eye.svg',
            width: MediaQuery.of(context).size.width * 0.45,
          ),
          SizedBox(height: 16),
          Align(
              alignment: Alignment.center,
              child: Text('Welcome To Vision Log!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ))),
          Text('A dream journal made simple.',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              )),
          Spacer(),
          Spacer(),
          IconButton(
            icon: Image.asset('assets/sign_in_with_google.png'),
            iconSize: MediaQuery.of(context).size.width * 0.5,
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.googleLogin();
            },
          ),
        ],
      ));
}
