import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/actions.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  String clientName = sl<LocalSource>().getClientName();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClientBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hour'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Center(
                child: Text(
              'Добро пожаловать',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40),
            )),
            const SizedBox(
              height: 50,
            ),
            Expanded(
              flex: 1,
              child: Text(clientName),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  const Text('Начать работу'),
                  ActionsButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
