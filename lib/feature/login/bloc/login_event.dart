part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class IsPasswordVisible extends LoginEvent {
  final bool isVisible;

  const IsPasswordVisible({required this.isVisible});

  @override
  List<Object?> get props => [isVisible];
}

class SubmitEvent extends LoginEvent {
  final BuildContext context;
  final String email;
  final String password;

  const SubmitEvent({
    required this.context,
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [password, email, context];
}

class EnviableSubmitButton extends LoginEvent {
  final String email;
  final String password;

  const EnviableSubmitButton({
    required this.password,
    required this.email,
  });

  @override
  List<Object?> get props => [email, password];
}
