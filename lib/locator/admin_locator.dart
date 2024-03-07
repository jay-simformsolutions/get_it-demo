import 'package:flutter/cupertino.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/post_repo/post_repo.dart';

Future<void> setUpAdminDependency() async{
  debugPrint('Admin Dependency Initialize');
  getIt.registerSingleton<AdminPostRepo>(AdminPostRepo());
}