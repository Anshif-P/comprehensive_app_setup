part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class AddUserDetailsSuccessState extends UserState {}

final class AddUserDetailsFailedState extends UserState {}
