import 'package:flutter/material.dart';
import 'package:get_it_demo/domain/model/user.dart';
import 'package:get_it_demo/locator.dart';
import 'package:get_it_demo/repository/user_repo.dart';
import 'package:get_it_demo/view/scope_demo/admin/admin.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  late TextEditingController username;
  late TextEditingController password;
  User? user;
  bool isUserLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    getIt.pushNewScope(scopeName: 'user');
    username = TextEditingController();
    password = TextEditingController();
    getIt.get<UserRepo>().getUser().then((value) {
      debugPrint('Value is ${value.username} and ${value.password}');
      user = value;
    });
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
              if (isUserLoginSuccess) ...{
                const Text('User Login Successfully'),
              } else ...{
                Column(
                  children: [
                    TextFormField(
                      controller: username,
                      decoration: const InputDecoration(
                        hintText: 'Enter Username',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: password,
                      decoration: const InputDecoration(
                        hintText: 'Enter Password',
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                )
              },
              ElevatedButton(
                onPressed: () {
                  if (user!.password == 'Simform@123' &&
                      user!.username == 'jay') {
                    setState(() {
                      isUserLoginSuccess = true;
                    });
                  }
                },
                child: const Text('Login as User'),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AdminWidget(),
                    ),
                  );
                },
                child: const Text('Switch to Admin'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
