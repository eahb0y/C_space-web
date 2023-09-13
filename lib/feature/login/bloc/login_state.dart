part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isVisible;
  final bool? emailCorrect;
  final bool? passwordCorrect;
  final bool? hasName;
  final bool isSuccess;

  const LoginState(
      {required this.isVisible,
      this.emailCorrect,
      this.passwordCorrect,
      this.hasName,
      required this.isSuccess});

  LoginState copyWith({
    bool? isVisible,
    bool? emailCorrect,
    bool? passwordCorrect,
    bool? hasName,
    bool? isSuccess,
  }) {
    return LoginState(
        isVisible: isVisible ?? this.isVisible,
        emailCorrect: emailCorrect ?? this.emailCorrect,
        hasName: hasName ?? this.hasName,
        passwordCorrect: passwordCorrect ?? this.passwordCorrect,
        isSuccess: isSuccess ?? this.isSuccess);
  }

  @override
  List<Object?> get props =>
      [isVisible, emailCorrect, hasName, passwordCorrect, isSuccess];
}
