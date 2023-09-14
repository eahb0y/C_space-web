import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/injection_container.dart';
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
              ClientInitial() => [
                  sl<LocalSource>().startTime()
                      ? IconButton(
                    icon: const Icon(Icons.pause_circle_filled_rounded),
                          onPressed: () {
                            context.read<ClientBloc>().add(TimerPausedEvent());
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              RoutName.totalPay,
                              (route) => false,
                            );
                          },
                    color: Colors.purple,
                    iconSize: 90,
                  )
                      : IconButton(
                          onPressed: () {
                            context.read<ClientBloc>().add(TimerStartEvent());
                            sl<LocalSource>().setStartTime(true);
                          },
                          icon: const Icon(Icons.play_arrow_sharp),
                    color: Colors.purple,
                    iconSize: 90,
                          )
                ],
              ClientTimerCompleted() => [
                IconButton(
                      onPressed: () {
                        context.read<ClientBloc>().add(TimerPausedEvent());
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          RoutName.totalPay,
                              (route) => false,
                        );
                      },
                    icon: const Icon(Icons.pause_circle_filled_rounded),
                  color: Colors.purple,
                  iconSize: 90,
                  ),
                ],
            }
          ],
        );
      },
    );
  }
}
