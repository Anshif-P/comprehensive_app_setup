part of 'user_bloc.dart';

abstract class UserState {}

final class UserInitial extends UserState {}

final class AddUserDetailsSuccessState extends UserState {}

final class AddUserDetailsFailedState extends UserState {}

final class GetUserDetailsSuccessState extends UserState {
  final User userDetails;

  GetUserDetailsSuccessState({required this.userDetails});
}

final class GetUserDetailsFailedState extends UserState {}

final class ImageUpdateSuccessState extends UserState {
  final String imagePath;

  ImageUpdateSuccessState({required this.imagePath});
}
