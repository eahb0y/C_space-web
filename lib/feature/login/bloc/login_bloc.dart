import 'package:c_space_web/core/local_data/local_source.dart';
import 'package:c_space_web/feature/login/arguments/login_argument.dart';
import 'package:c_space_web/injection_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  void _visiblePassword(IsPasswordVisible event, Emitter<LoginState> emit) {
    emit(state.copyWith(isVisible: !event.isVisible));
  }

  Future<void> _isEmailCorrect(
      SubmitEvent event, Emitter<LoginState> emit) async {
    if (event.password.isNotEmpty && event.email.isNotEmpty) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: event.email, password: event.password)
            .then((value) async {
          await _setUser(event.email);
          emit(state.copyWith(isSuccess: true));
        });
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          emit(state.copyWith(isSuccess: false));
        } else if (e.code == 'wrong-password') {
          emit(state.copyWith(isSuccess: false));
        }
      }
    }
  }

  Future<void> _setUser(String email) async{
    late LoginArgument argument;
    final response = await FirebaseFirestore.instance
        .collection('email')
        .where('email', isEqualTo: email)
        .get();
    for(var element in response.docs){
      argument = LoginArgument.fromFirebase(element.data());
    }
    print(response.docs[0]);
    sl<LocalSource>().setClientName(name: argument.name);
  }

}
