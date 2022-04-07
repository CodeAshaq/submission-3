import 'dart:async';

import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';



class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  static const routeName = '/splash_page';

  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    //bisa diganti beberapa detik sesuai keinginan
    var durasiSplash = const Duration(seconds: 2);

    return Timer(durasiSplash, () {
      //pindah ke halaman home
      Navigator.pushReplacementNamed(
        context,
        HomePage.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD30000),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
                Image.asset(
              'images/chef-14524.png',
              width: 200,
              height: 200,
            ),
            Text(
              'RESTAURANT',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            const CircularProgressIndicator(color: Colors.white,)
          ],
        ),
      ),
    );
  }
}
