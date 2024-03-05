import 'package:get_it/get_it.dart';
import 'package:get_it_demo/domain/meme_controller.dart';
import 'package:get_it_demo/repository/meme_repo.dart';
import 'package:get_it_demo/repository/user_repo.dart';

final getIt = GetIt.I;

Future<void> setup() async {
  getIt.allowReassignment = true;

  getIt.registerLazySingleton<MemeRepo>(() => MemeRepo());

  getIt.registerLazySingleton<MemeController>(() => MemeController());

  getIt.registerLazySingleton<UserRepo>(() => UserRepo());
}
