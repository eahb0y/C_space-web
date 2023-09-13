part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isVisible;
  final bool? emailCorrect;
  final bool? passwordCorrect;
  final bool? hasName;
  final bool isSuccess;

  const AuthState({
    required this.isVisible,
    this.emailCorrect,
    this.passwordCorrect,
    this.hasName,
    required this.isSuccess,
  });

  AuthState copyWith({
    bool? isVisible,
    bool? emailCorrect,
    bool? passwordCorrect,
    bool? hasName,
    bool? isSuccess,
  }) {
    return AuthState(
      isSuccess: isSuccess ?? this.isSuccess,
      isVisible: isVisible ?? this.isVisible,
      passwordCorrect: passwordCorrect ?? this.passwordCorrect,
      hasName: hasName ?? this.hasName,
      emailCorrect: emailCorrect ?? this.emailCorrect,
    );
  }

  @override
  List<Object?> get props => [
        isSuccess,
        isVisible,
        passwordCorrect,
        hasName,
        emailCorrect,
      ];
}
