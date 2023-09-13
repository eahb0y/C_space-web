import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState(isVisible: false, isSuccess: false)) {
    on<IsPasswordVisible>(_visiblePassword);
    on<SubmitEvent>(_isEmailCorrect);
  }

  void _visiblePassword(IsPasswordVisible  event, Emitter<LoginState> emit){
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  void _isEmailCorrect(SubmitEvent event, Emitter<LoginState> emit){
      try{
        FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
        emit(state.copyWith(isSuccess: true));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(state.copyWith(isSuccess: false));
        } else if (e.code == 'wrong-password') {
          emit(state.copyWith(isSuccess: false));
        }
      }
}}
