part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {}

// ignore: must_be_immutable
final class RegisterFailure extends RegisterState {
  String errMessage;
  RegisterFailure({required this.errMessage});
}
