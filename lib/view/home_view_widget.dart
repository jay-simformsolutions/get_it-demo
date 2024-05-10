import 'package:flutter/material.dart';
import 'package:get_it_demo/view/payment/payment_screen.dart';
import 'package:get_it_demo/view/ramdom_image/random_image.dart';
import 'package:get_it_demo/view/scope_demo/user/user_login.dart';
import 'package:get_it_demo/view/shadow_object_widget/shadow_object_class1.dart';

class HomeViewWidget extends StatefulWidget {
  const HomeViewWidget({super.key});

  @override
  State<HomeViewWidget> createState() => _HomeViewWidgetState();
}

class _HomeViewWidgetState extends State<HomeViewWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RandomImage(),
                  ),
                );
              },
              child: const Text('Api Calling with Get_it'),
            ),
            ElevatedButton(
              onPressed: () async{
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const UserLogin()),
                  );
              },
              child: const Text('Scope Concept'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PaymentScreen()),
                );
              },
              child: const Text('Make Payment'),
            ),ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ShadowObjectClassWidget1()),
                );
              },
              child: const Text('Shadow Concept'),
            ),
          ],
        ),
      ),
    );
  }
}
