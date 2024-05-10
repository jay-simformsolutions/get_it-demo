import 'package:flutter/material.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/shadow_object/shadow_object.dart';

class ShadowObjectClassWidget1 extends StatefulWidget {
  const ShadowObjectClassWidget1({super.key});

  @override
  State<ShadowObjectClassWidget1> createState() =>
      _ShadowObjectClassWidget1State();
}

class _ShadowObjectClassWidget1State extends State<ShadowObjectClassWidget1> {
  @override
  void initState() {
    super.initState();
    getIt.pushNewScope(
      scopeName: 'shadow_scope_1',
      init: (getIt) {
        getIt.registerSingleton<ShadowObject>(ShadowObject());
        getIt.get<ShadowObject>().initializeFirstAndSecond();
      },
    );
    getIt.pushNewScope(
      scopeName: 'shadow_scope_2',
      init: (getIt) {
        getIt.registerSingleton<ShadowObject>(ShadowObject());
        getIt.get<ShadowObject>().initializeThirdAndFourth();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(getIt.get<ShadowObject>().var1.toString()),
            Text(getIt.get<ShadowObject>().var2.toString()),
            ElevatedButton(
                onPressed: () async {
                  final shadow = getIt.get<ShadowObject>();
                  debugPrint(shadow.toString());
                  await getIt.popScope();
                  final shadow2 = getIt.get<ShadowObject>();
                  debugPrint(shadow2.toString());
                  await getIt.popScope();
                  if (getIt.isRegistered<ShadowObject>()) {
                    final shadow3 = getIt.get<ShadowObject>();
                    debugPrint(shadow3.toString());
                  } else {
                    debugPrint('No Parent Object is found');
                  }
                },
                child: const Text('Button'))
          ],
        ),
      ),
    );
  }
}
