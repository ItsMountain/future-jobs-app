import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(
          context, '/onboarding', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff4141A4),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              child: Image.asset(
            'assets/logo.png',
            height: 76,
            width: 59,
          )),
          SizedBox(
            height: 30,
          ),
          Text(
            'FUTURE JOB',
            style: GoogleFonts.poppins(
                color: Color(0xffFFFFFF),
                fontSize: 32,
                fontWeight: FontWeight.w600),
          )
        ]),
      ),
    );
  }
}

// ignore_for_file: prefer_const_constructors