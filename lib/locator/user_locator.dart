import 'package:flutter/material.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/user_profile_repo/user_profile_repo.dart';

Future<void> setUpUserDependency() async {
  getIt.registerLazySingleton(() {
    debugPrint('User Dependency is initialize');
    return UserProfileRepo();
  });
}
