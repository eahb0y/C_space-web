part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final bool isVisible;
  final bool isSuccess;
  final String? errorStatus;
  final bool enviable;
  final bool isLoading;

  const AuthState({
    required this.isVisible,
    required this.isSuccess,
    required this.isLoading,
    required this.enviable,
    this.errorStatus,
  });

  AuthState copyWith({
    bool? isVisible,
    bool? isSuccess,
    bool? isLoading,
    bool? enviable,
    String? errorStatus,
  }) {
    return AuthState(
      isSuccess: isSuccess ?? this.isSuccess,
      isVisible: isVisible ?? this.isVisible,
      enviable: enviable ?? this.enviable,
      isLoading: isLoading ?? this.isLoading,
      errorStatus: errorStatus ?? this.errorStatus,
    );
  }

  @override
  List<Object?> get props =>
      [isSuccess, isVisible, enviable, isLoading, errorStatus];
}
