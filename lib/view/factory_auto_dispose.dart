import 'package:flutter/material.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/random_num_repo.dart';

class FactoryAutoDisposeWidget extends StatefulWidget {
  const FactoryAutoDisposeWidget({required this.randomNumberRepo, super.key});

  final RandomNumberRepo randomNumberRepo;

  @override
  State<FactoryAutoDisposeWidget> createState() =>
      _FactoryAutoDisposeWidgetState();
}

class _FactoryAutoDisposeWidgetState extends State<FactoryAutoDisposeWidget> {

  @override
  void dispose() {
    getIt.unregister<RandomNumberRepo>(instanceName: 'registerFactory');
    debugPrint('Dispose Factory');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.randomNumberRepo.setValue(35);
    debugPrint('Hash code is ${widget.randomNumberRepo.hashCode}');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.randomNumberRepo.getRandomNumberRepo().toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16,),
            Text(
              widget.randomNumberRepo.value.toString(),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
