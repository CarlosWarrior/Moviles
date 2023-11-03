part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthCheckEvent extends AuthEvent {}

class AuthLogoutEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool keepConnected;

  AuthLoginEvent({
    required this.email,
    required this.password,
    required this.keepConnected,
  });

  @override
  List<Object> get props => [email, password];
}

class AuthRegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  AuthRegisterEvent({
    required this.email,
    required this.password,
    required this.name,
  });

  @override
  List<Object> get props => [email, password, name];
}

class ChangePasswordEvent extends AuthEvent {
  final String password;

  ChangePasswordEvent({required this.password});

  @override
  List<Object> get props => [password];
}
