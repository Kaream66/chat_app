part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

// ignore: must_be_immutable
final class RegisterFailure extends AuthState {
  String errMessage;
  RegisterFailure({required this.errMessage});
}

final class LoginSuccess extends AuthState {}

final class LoginLoading extends AuthState {}

// ignore: must_be_immutable
final class LoginFailure extends AuthState {
  String errMessage;
  LoginFailure({required this.errMessage});
}
