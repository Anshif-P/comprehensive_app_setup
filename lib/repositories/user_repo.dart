import 'package:finfresh_machin_task/model/user_model.dart';
import 'package:finfresh_machin_task/network/local_data_base/local_storage.dart';

class UserRepo {
  Future<int> inserUserDetialsToDatabase(Map<String, dynamic> map) async =>
      DatabaseHelper.instance.insertOrUpdateUserDetails(map);

  Future<User?> getUserDetailsFromDatabase() async =>
      DatabaseHelper.instance.getUserDetails();
}
