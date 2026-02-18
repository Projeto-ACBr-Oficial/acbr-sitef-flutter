import 'package:fintesthub_flutter/ui/splash/splash_controller.dart';
import 'package:flutter/material.dart';

import '../_core/app_colors.dart';
import '../home/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = SplashController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.isReadyToNavigate) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      }
    });

    _controller.validateAndProceed();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/ic_credit_card.png'),
            const SizedBox(height: 10),
            Text(
              'Fiserv Flutter',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 5),
            Text(
              'Demo',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(color: AppColors.primary),
          ],
        ),
      ),
    );
  }
}
