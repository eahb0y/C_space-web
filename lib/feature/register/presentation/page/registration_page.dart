import 'package:c_space_web/feature/login/page/widgets/custom_text_field.dart';
import 'package:c_space_web/feature/register/presentation/bloc/auth_bloc.dart';
import 'package:c_space_web/feature/register/presentation/mixin/auth_mixin.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with AuthMixin {
  @override
  void initState() {
    initController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushNamedAndRemoveUntil(context, RoutName.main, (route) => false,);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Colors.black, //change your color here
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        const SafeArea(
                            child: SizedBox(
                          height: 70,
                        )),
                        Stack(children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: Ink(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 70,
                              ),
                              child: Image.asset(
                                'assets/images/c_space.png',
                              ),
                            ),
                          ),
                        ]),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomTextField(
                          controller: name,
                          hintText: "Name",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: email,
                          hintText: "Email",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextField(
                          controller: password,
                          hintText: "Password",
                          isVisible: state.isVisible,
                          suffix: GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(
                                  PasswordVisible(isVisible: state.isVisible));
                            },
                            child: state.isVisible
                                ? const Icon(Icons.remove_red_eye)
                                : const Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: () {
                  context.read<AuthBloc>().add(
                        SubmitButtonEvent(
                            password: password.text,
                            email: email.text,
                            name: name.text),
                      );
                },
                child: const Text("Войти"),
              ),
            ),
          );
        },
      ),
    );
  }
}
