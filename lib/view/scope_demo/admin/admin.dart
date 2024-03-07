import 'package:flutter/material.dart';
import 'package:get_it_demo/const.dart';
import 'package:get_it_demo/domain/model/user.dart';
import 'package:get_it_demo/locator/admin_locator.dart';
import 'package:get_it_demo/locator/locator.dart';
import 'package:get_it_demo/repository/user_repo.dart';
import 'package:get_it_demo/view/scope_demo/admin/admin_post_widget.dart';
import 'package:get_it_demo/view/scope_demo/user/user_login.dart';

class AdminWidget extends StatefulWidget {
  const AdminWidget({super.key});

  @override
  State<AdminWidget> createState() => _AdminWidgetState();
}

class _AdminWidgetState extends State<AdminWidget> {
  late TextEditingController adminUserName;
  late TextEditingController adminPassword;
  User? adminUser;
  bool isAdminLoginSuccess = false;

  @override
  void initState() {
    super.initState();
    adminUserName = TextEditingController();
    adminPassword = TextEditingController();
    getIt.pushNewScope(
      scopeName: Const.adminScope,
      init: (getIt) async{
        await setUpAdminDependency();
        getIt.get<UserRepo>().getUser().then((value) {
          adminUser = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: adminUserName,
                  decoration: const InputDecoration(
                    hintText: 'Enter Admin Username',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value != adminUser?.username && value!.isNotEmpty) {
                      return 'Enter valid username';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: adminPassword,
                  decoration: const InputDecoration(
                    hintText: 'Enter Admin Password',
                  ),
                  autovalidateMode: AutovalidateMode.always,
                  validator: (value) {
                    if (value != adminUser?.password && value!.isNotEmpty) {
                      return 'Enter valid password';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (adminPassword.text == adminUser!.password &&
                        adminUserName.text == adminUser!.username) {
                      setState(() {
                        isAdminLoginSuccess = true;
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AdminPostWidget(),
                        ),
                      );
                    }
                  },
                  child: const Text('Login as Admin'),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async{
                    if(getIt.hasScope('admin')){
                      await getIt.popScope();
                    }
                    if(context.mounted){
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
      ),
    );
  }
}
