import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/model/user_profile.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/user_profile_repo/user_profile_repo.dart';

class UserProfileListWidget extends StatefulWidget {
  const UserProfileListWidget({super.key});

  @override
  State<UserProfileListWidget> createState() => _UserProfileListWidgetState();
}

class _UserProfileListWidgetState extends State<UserProfileListWidget> {
  List<UserProfile> userProfileList = [];

  @override
  void initState() {
    super.initState();
    getIt.get<UserProfileRepo>().getUserProfileList().then((value) {
      userProfileList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: userProfileList.length,
        itemBuilder: (context, index) {
          return userProfileList.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _getRichTextWidget('Name: ', userProfileList[index].name),
                      const SizedBox(
                        height: 8,
                      ),
                      _getRichTextWidget(
                          'Username: ', userProfileList[index].username),
                      const SizedBox(
                        height: 8,
                      ),
                      _getRichTextWidget(
                          'email: ', userProfileList[index].email),
                      const SizedBox(
                        height: 8,
                      ),
                      _getRichTextWidget(
                          'Website: ', userProfileList[index].website),

                    ],
                  ),
                );
        }, separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(height: 16,);
      },
      ),
    );
  }

  Widget _getRichTextWidget(String title, String value) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
