part of 'login_bloc.dart';

class LoginState extends Equatable {
  final bool isVisible;
  final bool isSuccess;
  final bool enviable;
  final String? errorStatus;
  final bool isLoading;

  const LoginState({
    required this.isVisible,
    required this.isSuccess,
    required this.enviable,
    required this.isLoading,
    this.errorStatus,
  });

  LoginState copyWith({
    bool? isVisible,
    bool? emailCorrect,
    bool? passwordCorrect,
    bool? hasName,
    bool? isSuccess,
    bool? enviable,
    String? errorStatus,
    bool? isLoading,
  }) {
    return LoginState(
      isVisible: isVisible ?? this.isVisible,
      isSuccess: isSuccess ?? this.isSuccess,
      enviable: enviable ?? this.enviable,
      isLoading: isLoading ?? this.isLoading,
      errorStatus: errorStatus ?? this.errorStatus,
    );
  }

  @override
  List<Object?> get props =>
      [isVisible, isSuccess, enviable, isLoading, errorStatus];
}
