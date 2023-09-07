import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/main/presentation/bloc/client_bloc.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButton extends StatelessWidget {
  final String name;
  const CustomButton({
    super.key, required this.name,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
      child: IconButton(
        iconSize: 60,
        color: Colors.purple,
        onPressed: () {
          context.read<ClientBloc>().add(SetStartTime(
            name: name,
          ));
          Navigator.pushReplacementNamed(context, RoutName.stopTime);
          sl<LocalSource>().setStartTime(true);
        }, icon: const Icon(Icons.play_arrow),
      )
    );
  }
}
