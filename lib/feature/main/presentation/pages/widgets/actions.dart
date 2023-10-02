import 'package:c_space_web/core/theme/colors/app_colors.dart';
import 'package:c_space_web/core/theme/text_style/app_text_style.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionsButton extends StatelessWidget {
  const ActionsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...switch (state) {
              MainInitial() => [
                  Column(
                    children: [
                      const Text(
                        'Начать работу',
                        style: AppTextStyle.timerButton,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ClientBloc>().add(const TimerStartEvent());
                        },
                        icon: const Icon(Icons.play_circle),
                        iconSize: 73,
                        color: LightColorTheme.buttonBackgroundColor,
                      ),
                    ],
                  ),
                ],
              ClientTimerCompleted() => [
                  Column(
                    children: [
                      const Text(
                        'Остоновить',
                        style: AppTextStyle.timerButton,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            RoutName.totalPay,
                          );
                        },
                        icon: const Icon(Icons.pause_circle),
                        iconSize: 73,
                        color: LightColorTheme.buttonBackgroundColor,
                      ),
                    ],
                  ),
                ]
            }
          ],
        );
      },
    );
  }
}
