import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';

class StopTime extends StatelessWidget {
  const StopTime({super.key});

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Остановить счетчик', style: TextStyle(fontSize: 30),),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: IconButton(
                      iconSize: 90,
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, RoutName.totalPay);
                      },
                      color: Colors.purple,
                      highlightColor: Colors.purple.shade50,
                      splashRadius: 60,
                      icon: const Icon(Icons.pause_circle_filled_sharp)))
            ],
          ),
        );
  }
}
