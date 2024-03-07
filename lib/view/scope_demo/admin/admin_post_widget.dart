import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/model/post.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/post_repo/post_repo.dart';

class AdminPostWidget extends StatefulWidget {
  const AdminPostWidget({super.key});

  @override
  State<AdminPostWidget> createState() => _AdminPostWidgetState();
}

class _AdminPostWidgetState extends State<AdminPostWidget> {
  List<Post> postList = [];

  @override
  void initState() {
    super.initState();
    getIt.get<AdminPostRepo>().getPostList().then((value) {
      postList = value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        itemCount: postList.length,
        itemBuilder: (context, index) {
          return postList.isEmpty
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
                      _getRichTextWidget('Title: ', postList[index].title),
                      const SizedBox(
                        height: 8,
                      ),
                      _getRichTextWidget('Body: ', postList[index].body),
                    ],
                  ),
                );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 16,
          );
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
