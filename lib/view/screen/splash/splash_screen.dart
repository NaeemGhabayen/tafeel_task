import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:tafeel_task/provider/user_provider.dart';
import 'package:tafeel_task/utils/color_resources.dart';
import 'package:tafeel_task/utils/images.dart';
import 'package:tafeel_task/utils/navigation.dart';
import 'package:tafeel_task/view/screen/users/users_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = Provider.of<UserProvider>(context, listen: false);

      await provider.getUserListApi(context: context, currentPage: 1);
      await provider.getUserListApi(context: context, currentPage: 2);

      _route(context); // Navigate or update UI after both pages are loaded
    });
    super.initState();
  }

  void _route(context) async {
    AppNavigation.navigateAndFinish(context, const WelcomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Images.logo, fit: BoxFit.contain, scale: 1.9),
            SizedBox(width: 80, child: Lottie.asset(Images.animation)),
          ],
        ),
      ),
    );
  }
}
