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
            ...switch(state){
              ClientInitial() =>
              [
                FloatingActionButton(
                  child: const Icon(Icons.play_arrow),
                  onPressed: () =>
                      context
                          .read<ClientBloc>()
                          .add(TimerStartEvent()),
                ),
              ],
              ClientTimerCompleted() =>
              [
                FloatingActionButton(
                    child: const Icon(Icons.pause),
                    onPressed: () {
                      context.read<ClientBloc>().add(TimerPausedEvent());
                      Navigator.pushNamed(
                      context,
                      RoutName.totalPay,
                      );
                    }),
              ],
            }
          ],
        );
      },
    );
  }
}
