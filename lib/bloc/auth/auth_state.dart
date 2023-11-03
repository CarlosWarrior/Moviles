part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object> get props => [message];
}

final class AuthSuccess extends AuthState {
  final User user;

  AuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

final class AuthLogout extends AuthState {}
