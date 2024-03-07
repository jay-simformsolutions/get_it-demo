import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it_demo/domain/model/post.dart';
import 'package:http/http.dart' as http;

class AdminPostRepo{
  Future<List<Post>> getPostList() async{
    List<Post> postList = [];
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      final data = jsonDecode(response.body);
      postList = data.map<Post>((e) => Post.fromJson(e)).toList();
    }catch(e,s){
      debugPrint('Exception is $e');
      debugPrintStack(stackTrace: s);
    }
    return postList;
  }
}