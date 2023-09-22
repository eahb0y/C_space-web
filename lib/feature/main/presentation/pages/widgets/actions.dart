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
    String date = sl<LocalSource>().getDateTime();
    return BlocBuilder<ClientBloc, ClientState>(
      builder: (context, state) {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...switch (state) {
              ClientInitial() => [
                  sl<LocalSource>().startTime()
                      ? Column(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.pause_circle_filled_rounded),
                              onPressed: () {
                                context
                                    .read<ClientBloc>()
                                    .add(TimerPausedEvent());
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutName.totalPay,
                                  (route) => false,
                                );
                                sl<LocalSource>().removeStart();
                              },
                              color: Colors.purple,
                              iconSize: 90,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Начатое время : ",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 19,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  date,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        )
                      : Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                context
                                    .read<ClientBloc>()
                                    .add(TimerStartEvent());
                                sl<LocalSource>().setStartTime(true);
                              },
                              icon: const Icon(Icons.play_arrow_sharp),
                              color: Colors.purple,
                              iconSize: 90,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        )
                ],
              ClientTimerCompleted() => [
                  Column(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<ClientBloc>().add(TimerPausedEvent());
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            RoutName.totalPay,
                            (route) => false,
                          );
                          sl<LocalSource>().removeStart();
                        },
                        icon: const Icon(Icons.pause_circle_filled_rounded),
                        color: Colors.purple,
                        iconSize: 90,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text("Начатое время : ",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 19,
                                fontWeight: FontWeight.w600,
                              )),
                          Text(
                            state.dateTime ?? '',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
            }
          ],
        );
      },
    );
  }
}
