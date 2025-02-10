import 'dart:convert';

import 'package:app/features/auth/domain/entities/user.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  User? getLocalUser();
  Future<bool> logout();
  Future<bool> setLocalUser(User? me);
}

@Injectable(as: AuthLocalDataSource)
class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  const AuthLocalDataSourceImpl({
    required this.sharedPreferences,
  });

  final userKey = "user";

  @override
  User? getLocalUser() {
    final localUserString = sharedPreferences.getString(userKey);
    if (localUserString != null) {
      return User.fromJson(jsonDecode(localUserString));
    }
    return null;
  }

  @override
  Future<bool> logout() async {
    return await setLocalUser(null);
  }

  @override
  Future<bool> setLocalUser(User? user) async {
    if (user != null) {
      return await sharedPreferences.setString(userKey, jsonEncode(user));
    }
    return await sharedPreferences.remove(userKey);
  }
}
