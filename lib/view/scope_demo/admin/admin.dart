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
            Navigator.pop(context);
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
              const SizedBox(height: 16,),
              Text(
                  getIt.get<CounterRepo>().counter.toString(),
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    getIt.get<CounterRepo>().increment();
                    setState(() {});
                  }, icon: const Icon(Icons.add)),
                  IconButton(onPressed: (){
                    getIt.get<CounterRepo>().increment();
                    setState(() {});
                  }, icon: const Icon(Icons.remove)),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                },
                child: const Text('Login as Admin'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  if(getIt.hasScope('user')){
                    getIt.popScopesTill('user',inclusive: false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const UserLogin(),
                      ),
                    );
                  }else{
                    Navigator.push(
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
