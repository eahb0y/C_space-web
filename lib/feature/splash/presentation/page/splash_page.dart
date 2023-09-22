import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  var pref = SharedPreferences.getInstance();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        FlutterNativeSplash.remove();
      },
    );
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        if (context.mounted) {
          if (sl<LocalSource>().dataExist()) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              RoutName.main,
                  (route) => false,
            );
          } else {
            Navigator.of(context).pushReplacementNamed(RoutName.login);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          height: 100,
          child: Lottie.asset(
            'assets/animation/loading_animation.json',
            fit: BoxFit.cover,
          ),
          //fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
