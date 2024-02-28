import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/meme_repo.dart';

import 'model/photos.dart';

class MemeController{
  Future<Photo> getNextMeme() async{
    /// Returns Future object which is not initialize
    MemeRepo memeRepo =  await getIt.getAsync<MemeRepo>();
    debugPrint('Will return Async value');
    return memeRepo.getMeme();
  }
}