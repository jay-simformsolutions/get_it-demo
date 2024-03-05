import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/model/user.dart';
import 'package:http/http.dart' as http;

class UserRepo{
  Future<User> getUser() async{
    final response = await http.get(Uri.parse("https://36053ddc861e49cfbf2e164ebbe50d5b.api.mockbin.io/"));
    final data = jsonDecode(response.body);
    debugPrint('Data is $data');
    return User.fromJson(data);
  }
}