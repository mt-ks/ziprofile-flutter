import 'package:shared_preferences/shared_preferences.dart';
import '../storage/cloud_storage.dart';
import '../storage/oauth2_storage.dart';
import '../storage/user_storage.dart';

class SharedPrefs {
  static SharedPreferences? _sharedPrefs = null;

  factory SharedPrefs() => SharedPrefs._internal();

  SharedPrefs._internal();

  Future<void> init() async {
    _sharedPrefs ??= await SharedPreferences.getInstance();
  }

  UserStorageDB get userStorage => UserStorageDB(_sharedPrefs!);
  CloudStorageDB get cloudStorage => CloudStorageDB(_sharedPrefs!);
  Oauth2StorageDB get oauth2Storage => Oauth2StorageDB(_sharedPrefs!);
}
