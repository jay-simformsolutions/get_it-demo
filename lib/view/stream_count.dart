import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/stream_repo.dart';

class StreamCount extends StatefulWidget {
  const StreamCount({super.key});

  @override
  State<StreamCount> createState() => _StreamCountState();
}

class _StreamCountState extends State<StreamCount> {

  @override
  void dispose() {
    debugPrint('Object is unregister');
    /// Whenever we called unregister it will called dispose method
    getIt.unregister<StreamRepo>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
          child: FutureBuilder(
            future: getIt.allReady(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                return TextField(
                  controller: getIt.get<StreamRepo>().textEditingController,
                );
              }else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
    )),
    );
  }
}
