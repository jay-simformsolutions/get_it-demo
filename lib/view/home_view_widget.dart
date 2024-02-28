import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_demo/domain/meme_controller.dart';
import 'package:get_it_demo/domain/model/photos.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/view/stream_count.dart';

class HomeViewWidget extends StatefulWidget {
  const HomeViewWidget({super.key});

  @override
  State<HomeViewWidget> createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> {
  Photo? photo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const StreamCount()));
                          },
                          child: const Text('Go To Next Page'),
                        ),
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
          final visibleMeme = await getIt.get<MemeController>().getNextMeme();
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
