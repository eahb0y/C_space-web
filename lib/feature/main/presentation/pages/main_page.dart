import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/core/theme/text_style/app_text_style.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/actions.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/start_time_widget.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/timer_widget.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dialog/custom_dialog.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  String clientName = sl<LocalSource>().getClientName();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientBloc(),
      child: BlocBuilder<ClientBloc, ClientState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Главная',
                  style: AppTextStyle.appBarText,
                ),
                centerTitle: true,
                backgroundColor: Colors.purple,
                actions: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => const CustomDialog());
                    },
                    icon: const Icon(Icons.exit_to_app_sharp),
                  ),
                ]),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Привет, ${sl<LocalSource>().getClientName()}",
                    style: AppTextStyle.helloText,
                  ),
                  ...switch (state) {
                    MainInitial() => [
                        const Column(
                          children: [
                            StartTimeWidget(
                              startTime: '',
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            TimerWidget()
                          ],
                        )
                      ],
                    ClientTimerCompleted() => [
                        Column(
                          children: [
                            StartTimeWidget(
                              startTime: sl<LocalSource>().getDateTime(),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            TimerWidget(
                              statusUpdateTime: DateTime.tryParse(
                                  sl<LocalSource>().getDateTime()),
                            )
                          ],
                        )
                      ],
                  },
                  const SizedBox(
                    height: 70,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const SafeArea(
              minimum: EdgeInsets.only(bottom: 50),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ActionsButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
