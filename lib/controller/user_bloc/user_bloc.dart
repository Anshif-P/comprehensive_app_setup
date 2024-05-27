import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:finfresh_machin_task/model/user_model.dart';
import 'package:finfresh_machin_task/repositories/user_repo.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    on<AddUserDetailsToDatabase>(addUserDetailsToDatabase);
    on<GetUserDetailsFromDatabaseEvent>(getUserDetailsFromDatabaseEvent);
    on<UpdateImageEvent>(updateImageEvent);
  }
  FutureOr<void> addUserDetailsToDatabase(
      AddUserDetailsToDatabase event, Emitter<UserState> emit) async {
    await UserRepo().inserUserDetialsToDatabase(
        {'imagePath': event.imagePath, 'id': event.userId ?? -1});

    emit(AddUserDetailsSuccessState());
  }

  FutureOr<void> getUserDetailsFromDatabaseEvent(
      GetUserDetailsFromDatabaseEvent event, Emitter<UserState> emit) async {
    final result = await UserRepo().getUserDetailsFromDatabase();

    if (result != null) {
      emit(GetUserDetailsSuccessState(userDetails: result));
    } else {
      emit(GetUserDetailsFailedState());
    }
  }

  FutureOr<void> updateImageEvent(
      UpdateImageEvent event, Emitter<UserState> emit) {
    if (event.imagePath != '') {
      emit(ImageUpdateSuccessState(imagePath: event.imagePath));
    }
  }
}
