import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/meme_repo.dart';

import 'model/photos.dart';

class MemeController{
  Future<Photo> getNextMeme() async{
    /// Returns Future object which is not initialize
    MemeRepo memeRepo =  getIt.get<MemeRepo>();
    return memeRepo.getMeme();
  }
}