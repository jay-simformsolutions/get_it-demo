import 'package:flutter/material.dart';
import 'package:get_it_demo/locator.dart';

import 'view/home_view_widget.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeViewWidget(),
    );
  }
}
