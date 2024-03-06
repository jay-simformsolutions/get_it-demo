import 'package:flutter/material.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/counter_repo.dart';
import 'package:get_it_demo/view/scope_demo/user/user_login.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  late TextEditingController adminUserName;
  late TextEditingController adminPassword;

  @override
  void initState() {
    super.initState();
    getIt.pushNewScope(
      scopeName: 'admin',
      dispose: () {
        debugPrint('Controller is Dispose');
        adminUserName.dispose();
        adminPassword.dispose();
        getIt.unregister<CounterRepo>();
      },
      init: (getIt) {
        getIt.registerLazySingleton(() => CounterRepo());
      },
    );
    adminUserName = TextEditingController();
    adminPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            debugPrint('Current Scope name in Admin page is ${getIt.currentScopeName}');
            if(getIt.hasScope('admin')){
              Navigator.pop(context);
            }else{
              Navigator.pop(context);
            }
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextFormField(
                    controller: adminUserName,
                    decoration: const InputDecoration(
                      hintText: 'Enter Admin Username',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: adminPassword,
                    decoration: const InputDecoration(
                      hintText: 'Enter Admin Password',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                getIt.get<CounterRepo>().counter.toString(),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        getIt.get<CounterRepo>().increment();
                        setState(() {});
                      },
                      icon: const Icon(Icons.add)),
                  IconButton(
                      onPressed: () {
                        getIt.get<CounterRepo>().decrement();
                        setState(() {});
                      },
                      icon: const Icon(Icons.remove)),
                ],
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Login as Admin'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  getIt.dropScope('admin');
                  if (getIt.hasScope('user')) {
                    debugPrint('User scope is already present in admin page and need to remove it');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserLogin(),
                      ),
                    );
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserLogin(),
                      ),
                    );
                  }
                },
                child: const Text('Switch to User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
