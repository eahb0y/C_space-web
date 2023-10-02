import 'package:c_space_web/core/theme/colors/app_colors.dart';
import 'package:c_space_web/core/widgets/cutom_button/custom_button.dart';
import 'package:c_space_web/feature/login/bloc/login_bloc.dart';
import 'package:c_space_web/feature/login/mixin/login_mixin.dart';
import 'package:c_space_web/feature/login/page/widgets/custom_text_field.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  @override
  void initState() {
    initController();
    super.initState();
  }

  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isSuccess) {
          Navigator.pushReplacementNamed(context, RoutName.main);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme:
                  const IconThemeData(color: AppColors.buttonBackgroundColor),
            ),
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              minimum: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    'assets/svg/ic_c_space_logo.svg',
                    height: 67,
                  ),
                  Column(
                    children: [
                      CustomTextField(
                        controller: email,
                        hintText: "Email",
                        onTextChange: (value) {
                          context.read<LoginBloc>().add(EnviableSubmitButton(
                                password: password.text,
                                email: value,
                              ));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        onTextChange: (value) {
                          context.read<LoginBloc>().add(EnviableSubmitButton(
                                password: value,
                                email: email.text,
                              ));
                        },
                        controller: password,
                        hintText: "Password",
                        isVisible: state.isVisible,
                        suffix: IconButton(
                          onPressed: () {
                            context.read<LoginBloc>().add(
                                  IsPasswordVisible(isVisible: state.isVisible),
                                );
                          },
                          icon: state.isVisible
                              ? const Icon(Icons.remove_red_eye)
                              : const Icon(Icons.remove_red_eye_outlined),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      state.isSuccess
                          ? const SizedBox()
                          : Text(
                              state.errorStatus ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.red,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
            bottomNavigationBar: SafeArea(
              minimum: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),
              child: CustomButton(
                onPressed: state.enviable
                    ? () {
                        context.read<LoginBloc>().add(
                              SubmitEvent(
                                password: password.text,
                                email: email.text,
                                context: context,
                              ),
                            );
                      }
                    : null,
                borderColor: state.enviable
                    ? AppColors.buttonBorderSidedColor
                    : Colors.white70,
                color: AppColors.buttonBackgroundColor,
                buttonText: 'Войти',
                isLoading: state.isLoading,
              ),
            ),
          );
        },
      ),
    );
  }
}
