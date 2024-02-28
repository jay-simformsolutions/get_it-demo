import 'dart:convert';

import 'package:get_it_demo/domain/model/photos.dart';
import 'package:http/http.dart' as http;

class MemeRepo{
  Future<Photo> getMeme() async{
    final response = await http.get(Uri.parse("https://random.imagecdn.app/v1/image?width=500&height=150&category=buildings&format=json"));
    final data = jsonDecode(response.body);
    return Photo.fromJson(data);

  }
}