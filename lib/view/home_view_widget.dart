import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/meme_controller.dart';
import 'package:get_it_demo/domain/model/photos.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/random_num_repo.dart';
import 'package:get_it_demo/repository/stream_repo.dart';
import 'package:get_it_demo/view/factory_auto_dispose.dart';
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
            onPressed: () {
              if (getIt.isRegistered<StreamRepo>()) {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const StreamCount();
                }));
              } else {
                getIt.registerLazySingleton(() => StreamRepo());
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return const StreamCount();
                }));
              }
            },
            child: const Text('Go To Next Page'),
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint(
                  'Initial value is ${getIt.get<RandomNumberRepo>().value}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FactoryAutoDisposeWidget(
                    randomNumberRepo: getIt.get<RandomNumberRepo>(),
                  ),
                ),
              );
            },
            child: const Text('Check Factory is Auto Dispose'),
          ),
          ElevatedButton(
            onPressed: () {
              debugPrint(
                  'Initial value is ${getIt.get<RandomNumberRepo>().value}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => FactoryAutoDisposeWidget(
                    randomNumberRepo: getIt.get<RandomNumberRepo>(),
                  ),
                ),
              );
            },
            child: const Text('Scope Concept'),
          ),
        ],
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
