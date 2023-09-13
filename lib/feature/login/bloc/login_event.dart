part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {}

class IsPasswordVisible extends LoginEvent {
  final bool isVisible;

  IsPasswordVisible({required this.isVisible});

  @override
  List<Object?> get props => [isVisible];
}

class SubmitEvent extends LoginEvent {
  final String email;
  final String password;

  SubmitEvent({
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [password, email];
}
