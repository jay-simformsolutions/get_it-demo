import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_it_demo/domain/model/user_profile.dart';
import 'package:http/http.dart' as http;

class UserProfileRepo{
  Future<List<UserProfile>> getUserProfileList() async{
    List<UserProfile> userProfileList = [];
    try{
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      final data = jsonDecode(response.body);
      debugPrint('Data is $data');
      userProfileList = data.map<UserProfile>((e) => UserProfile.fromJson(e)).toList();
    }catch(e,s){
      debugPrint('Exception is $e');
      debugPrintStack(stackTrace: s);
    }
    return userProfileList;
  }
}