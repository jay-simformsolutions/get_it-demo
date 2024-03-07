import 'package:flutter/material.dart';
import 'package:get_it_demo/const.dart';
import 'package:get_it_demo/domain/model/user.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/locator/user_locator.dart';
import 'package:get_it_demo/repository/user_repo.dart';
import 'package:get_it_demo/view/scope_demo/admin/admin.dart';
import 'package:get_it_demo/view/scope_demo/user/user_profile_list_widget.dart';

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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    password = TextEditingController();
    getIt.pushNewScope(
      scopeName: Const.userScope,
      init: (getIt) async{
        await setUpUserDependency();
        getIt.get<UserRepo>().getUser().then((value) {
          user = value;
        });
      },
    );
  }

  @override
  void dispose() {
    getIt.popScope();
    super.dispose();
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
      body: Form(
        key: _formKey,
        child: Center(
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
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value != 'jay' && value!.isNotEmpty) {
                            return 'Enter valid username';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: const InputDecoration(
                          hintText: 'Enter Password',
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        validator: (value) {
                          if (value != 'Simform@123' && value!.isNotEmpty) {
                            return 'Enter valid password';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  )
                },
                ElevatedButton(
                  onPressed: () {
                    if (password.text == user!.password &&
                        username.text == user!.username) {
                      setState(() {
                        isUserLoginSuccess = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const UserProfileListWidget(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login as User'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async{
                    if(getIt.hasScope('user')){
                      await getIt.popScope();
                    }
                    debugPrint('Current Scope name is ${getIt.currentScopeName}');
                    if(context.mounted){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminWidget(),
                        ),
                      );
                    }
                  },
                  child: const Text('Switch to Admin'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
