import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/meme_controller.dart';
import 'package:get_it_demo/domain/model/photos.dart';
import 'package:get_it_demo/locator/locator.dart';

class RandomImage extends StatefulWidget {
  const RandomImage({super.key});

  @override
  State<RandomImage> createState() => _RandomImageState();
}

class _RandomImageState extends State<RandomImage> {

  Photo? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black,),
        ),
        elevation: 0,
      ),
      body: Container(
        child: photo != null
            ? Center(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Category ${photo!.provider}",
                    style: const TextStyle(fontSize: 36),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                    child: Image.network(photo!.url),
                  ),
                  const SizedBox(height: 8),
                  Text("Caption: ${photo!.terms}"),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        )
            : const Center(
          child: Text("No Meme loaded yet"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final visibleMeme =  await getIt.get<MemeController>().getNextMeme();
          debugPrint(
              'Meme is ${visibleMeme.url} and provider is ${visibleMeme.provider}');
          setState(() {
            photo = visibleMeme;
          });
        },
        child: const Icon(Icons.skip_next),
      ),
    );
  }
}
