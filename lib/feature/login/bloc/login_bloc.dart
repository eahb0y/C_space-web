import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/login/arguments/login_argument.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:c_space_web/router/rout_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(const LoginState(
          isLoading: false,
          enviable: false,
          isSuccess: false,
          isVisible: false,
        )) {
    on<IsPasswordVisible>(_visiblePassword);
    on<SubmitEvent>(_onSubmitButton);
    on<EnviableSubmitButton>(_enviableSubmitButton);
  }

  void _visiblePassword(IsPasswordVisible event, Emitter<LoginState> emit) {
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  void _enviableSubmitButton(
      EnviableSubmitButton event, Emitter<LoginState> emit) {
    if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(event.email) &&
        event.password.length > 1) {
      emit(state.copyWith(enviable: true));
    } else {
      emit(state.copyWith(enviable: false));
    }
  }

  Future<void> _onSubmitButton(
      SubmitEvent event, Emitter<LoginState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: event.email, password: event.password)
          .then((value) async {
        await _setUser(event.email);
        Navigator.pushNamed(event.context, RoutName.main);
        emit(state.copyWith(isSuccess: true));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(state.copyWith(
            isSuccess: false,
            errorStatus: 'Такого пользователя не существует',
            isLoading: false));
      } else if (e.code == 'wrong-password') {
        emit(state.copyWith(
            isSuccess: false,
            errorStatus: 'Неправильный пароль',
            isLoading: false));
      }
    } catch (e) {
      throw ' exsecpion ${e.toString()}';
    }
  }

  Future<void> _setUser(String email) async {
    late LoginArgument argument;
    final response = await FirebaseFirestore.instance
        .collection('email')
        .where('email', isEqualTo: email)
        .get();
    for (var element in response.docs) {
      argument = LoginArgument.fromFirebase(element.data());
    }
    sl<LocalSource>().setClientName(name: argument.name);
  }
}
