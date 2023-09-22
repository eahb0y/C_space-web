import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/feature/main/presentation/pages/widgets/actions.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
            title: Text(
              clientName,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
            ),
            centerTitle: true,
            toolbarHeight: 150,
            backgroundColor: Colors.purple,
            actions: [
              Column(
                children: [
                  IconButton(
                    iconSize: 30,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                      sl<LocalSource>().removeStart();
                      sl<LocalSource>().deleteData();
                      sl<LocalSource>().deleteDateTime();
                      Navigator.pushNamedAndRemoveUntil(context, RoutName.login, (route) => false);
                    },
                    icon: const Icon(Icons.exit_to_app_sharp),
                  ),
                ],
              ),
            ]),
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Добро пожаловать',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 40,
                  color: Colors.purple.shade400),
            ),
            Column(
              children: [
                Text(
                  'Начать работу',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.purple.shade500),
                ),
                const ActionsButton(),
                const SizedBox(
                  height: 60,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
