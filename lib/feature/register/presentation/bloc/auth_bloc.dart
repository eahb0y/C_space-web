import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc()
      : super(const AuthState(isVisible: false, isSuccess: false, error: '')) {
    on<PasswordVisible>(_visiblePassword);
    on<SubmitButtonEvent>(_isEmailCorrect);
  }

  void _visiblePassword(PasswordVisible event, Emitter<AuthState> emit) {
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  Future<void> _isEmailCorrect(
      SubmitButtonEvent event, Emitter<AuthState> emit) async {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(event.email);
    if (emailValid && event.password.isNotEmpty && event.name.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        )
            .then((value) {
          emit(state.copyWith(isSuccess: true),);
          sl<LocalSource>().setClientName(name: event.name);
        });
        await FirebaseFirestore.instance
            .collection('email')
            .doc(event.email)
            .set({
          'email' : event.email,
          'name': event.name,
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          emit(state.copyWith(isSuccess: false));
        } else if (e.code == 'email-already-in-use') {
          emit(state.copyWith(isSuccess: false));
        }
      } catch (e) {
        emit(state.copyWith(error: e.toString()));
      }
    }
  }
}
