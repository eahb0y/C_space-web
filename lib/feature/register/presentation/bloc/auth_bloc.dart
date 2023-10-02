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
      : super(const AuthState(
          isVisible: false,
          isSuccess: false,
          enviable: false,
          isLoading: false,
        )) {
    on<PasswordVisible>(_visiblePassword);
    on<SubmitButtonEvent>(_submitButton);
    on<EnviableSubmitButton>(_enviableSubmitButton);
  }

  void _visiblePassword(PasswordVisible event, Emitter<AuthState> emit) {
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  void _enviableSubmitButton(
      EnviableSubmitButton event, Emitter<AuthState> emit) {
    if (event.name.length > 1 &&
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(event.email) &&
        event.password.length > 3) {
      emit(state.copyWith(enviable: true));
    } else {
      emit(state.copyWith(enviable: false));
    }
  }

  Future<void> _submitButton(
      SubmitButtonEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      )
          .then((value) {
        emit(state.copyWith(isSuccess: true, isLoading: false));
        sl<LocalSource>().setClientName(name: event.name);
      });
      await FirebaseFirestore.instance
          .collection('hour')
          .doc(event.email)
          .set({
        'email': event.email,
        'name': event.name,
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(state.copyWith(
          isSuccess: false,
          errorStatus: 'Пароль должен содержать 8 символов',
          isLoading: false,
        ));
      } else if (e.code == 'email-already-in-use') {
        emit(state.copyWith(
          isSuccess: false,
          errorStatus:
          'Даннный аккаунт уже существует пожалуйста введите другую',
          isLoading: false,
        ));
      }
    } catch (e) {
      emit(state.copyWith(errorStatus: e.toString()));
    }
  }
}
