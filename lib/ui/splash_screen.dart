import 'package:exchange/ui/main_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    _handleScreen();

    var textTheme = Theme.of(context).textTheme;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              bottom: height / 3,
              child: Image.asset(
                'assets/images/logo.png',
                color: Color(0xff0005ce),
              ),
            ),
            Positioned(
              bottom: height / 13,
              child: Lottie.asset('assets/images/loading.json', height: 200),
            ),
            Positioned(
              bottom: height / 25,
              child: Text(
                'enjoye watching online cryptocurrencys...',
                style: textTheme.bodySmall,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _handleScreen() async {
    await Future.delayed(const Duration(seconds: 7));
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return MainWrapper();
      },
    ));
  }
}
