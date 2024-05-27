part of 'user_bloc.dart';

abstract class UserEvent {}

final class AddUserDetailsToDatabase extends UserEvent {
  final String imagePath;
  final int? userId;

  AddUserDetailsToDatabase({required this.imagePath, this.userId});
}

final class GetUserDetailsFromDatabaseEvent extends UserEvent {}

final class UpdateImageEvent extends UserEvent {
  final String imagePath;

  UpdateImageEvent({required this.imagePath});
}
