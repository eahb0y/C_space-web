import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState(isVisible: false, isSuccess: false)) {
    on<PasswordVisible>(_visiblePassword);
    on<SubmitButtonEvent>(_isEmailCorrect);
  }

  void _visiblePassword(PasswordVisible event, Emitter<AuthState> emit) {
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  void _isEmailCorrect(SubmitButtonEvent event, Emitter<AuthState> emit) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(event.email);
    if (emailValid && event.password.isNotEmpty && event.name.isNotEmpty) {
      try {
        FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(state.copyWith(isSuccess: true));
        sl<LocalSource>().setClientName(name: event.name);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(state.copyWith(isSuccess: false));
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          emit(state.copyWith(isSuccess: false));
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
