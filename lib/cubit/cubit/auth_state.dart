part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {
  final User? user;
  AuthInitial(this.user);
}

final class AuthLoading extends AuthState {
  AuthLoading();
}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthSuccessful extends AuthState {
  final User? user;
  AuthSuccessful(this.user);
}
