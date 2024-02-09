import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'activity/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double opacityLevel = 0;

  void _changeOpacity() {
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  @override
  void initState() {
    super.initState();
    NavigationToHome();
  }

  // ignore: non_constant_identifier_names
  NavigationToHome() async {
    await Future.delayed(const Duration(milliseconds: 1000), () {
      _changeOpacity();
    });
    setState(() {
      opacityLevel = 1;
    });
    await Future.delayed(const Duration(milliseconds: 3000), () {
      _changeOpacity();
      Future.delayed(const Duration(milliseconds: 2000), () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MyHomePage()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedOpacity(
                  opacity: opacityLevel,
                  duration: const Duration(seconds: 3),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/RMUTI_ICON.png',
                            height: 64,
                            width: 64,
                          ),
                          // const SizedBox(
                          //   width: 8,
                          // ),
                          // Image.asset(
                          //   'assets/images/carico.png',
                          //   height: 64,
                          //   width: 64,
                          // ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "License Plate Recognition",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const Text(
                        "มหาวิทยาลัยเทคโนโลยีราชมงคลอีสาน",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                      const Text(
                        "วิทยาเขตขอนแก่น",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
