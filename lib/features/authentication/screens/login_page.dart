import 'package:fashion_app/common/widgets/input_data.dart';
import 'package:fashion_app/features/authentication/screens/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 60),
                InputData(
                  isPassword: false,
                  type: TextInputType.emailAddress,
                  hintText: "example@email.com",
                  labelText: "Email",
                  extraValidate: (val) {
                    final reg = RegExp(
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
                    );
                    if (!reg.hasMatch(val!)) {
                      return "Not Email";
                    }
                    return null;
                  },
                  saved: (value) {},
                ),
                const SizedBox(height: 20),
                InputData(
                  isPassword: true,
                  type: TextInputType.visiblePassword,
                  hintText: "Password",
                  labelText: "Password",
                  extraValidate: (val) {
                    return null;
                  },
                  saved: (value) {},
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      if (_formKey.currentState!.validate()) {
                        print("All Fields are entered");
                      }
                    },
                    child: Text("Login"),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Get.to(() => RegisterPage());
                      },
                      child: Text("Create New"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
