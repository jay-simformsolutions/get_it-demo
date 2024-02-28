import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_demo/domain/meme_controller.dart';
import 'package:get_it_demo/repository/meme_repo.dart';
import 'package:get_it_demo/repository/stream_repo.dart';


final getIt = GetIt.I;

Future<void> setup() async{

  getIt.registerLazySingleton(() {
    debugPrint('New Object is created for Stream Repo');
    return StreamRepo();
  },
    /// Called when we unregister the object
    dispose: (param) {
    debugPrint('Check need to resource release');
    param.textEditingController.dispose();
    debugPrint('Text Editing Controller is released');
    },
  );

  /// If any object is register with Async and return Future
  getIt.registerLazySingletonAsync<MemeRepo>(() async {
    debugPrint('Async Object is initialized');
    return MemeRepo();
  });


  getIt.registerLazySingleton<MemeController>(() {
    debugPrint('New object is registered with MemeController');
    return MemeController();
  });
}
