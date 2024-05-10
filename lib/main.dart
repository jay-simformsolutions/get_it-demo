import 'package:flutter/material.dart';
import 'package:get_it_demo/locator/locator.dart';

import 'view/home_view_widget.dart';

/// Get is one type of service locator for access object in our app. Service
/// locator is way of decoupling interface from a concrete implementation.
/// We are using get it for access object from anywhere in our app. If we used provider or
/// Inherited widget to access object then we require context but in get it
/// without context we can access object in anywhere from our app.
///
///
/// At some point when our app is large and complex we need to move our app logic
/// in different file. But now we need to access those objects from the UI layer
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ///Initialize the service locator
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
