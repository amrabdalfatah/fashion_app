import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fashion_app/common/widgets/input_data.dart';
import 'package:fashion_app/features/home.dart';
import 'package:fashion_app/model/customer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String fullName = "";
  String email = "";
  String password = "";
  String phone = "";
  bool clicked = false;
  final auth = FirebaseAuth.instance;
  final collectionCustomer = FirebaseFirestore.instance.collection("Customers");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 60),
                  InputData(
                    isPassword: false,
                    type: TextInputType.text,
                    hintText: "Enter Full Name",
                    labelText: "Full Name",
                    extraValidate: (val) {
                      return null;
                    },
                    saved: (value) {
                      fullName = value!;
                    },
                  ),
                  const SizedBox(height: 20),
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
                    saved: (value) {
                      email = value!;
                    },
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
                    saved: (value) {
                      password = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  InputData(
                    isPassword: false,
                    type: TextInputType.phone,
                    hintText: "+20 1000000000",
                    labelText: "Phone",
                    extraValidate: (val) {
                      return null;
                    },
                    saved: (value) {
                      phone = value!;
                    },
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child:
                        clicked
                            ? Center(child: CircularProgressIndicator())
                            : ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  clicked = true;
                                });
                                _formKey.currentState!.save();
                                if (_formKey.currentState!.validate()) {
                                  try {
                                    final userCredential = await auth
                                        .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                    final customer = Customer(
                                      id: userCredential.user!.uid,
                                      fullName: fullName,
                                      email: email,
                                      phone: phone,
                                      age: 0,
                                      eyeColor: "",
                                      hairColor: "",
                                    );
                                    await collectionCustomer
                                        .doc(userCredential.user!.uid)
                                        .set(customer.toJson());
                                    // Navigate to another screen
                                    Get.snackbar(
                                      "Success",
                                      "Created Successfully",
                                      colorText: Colors.green,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                    Get.to(() => HomeScreen());
                                  } catch (error) {
                                    Get.snackbar(
                                      "Failed",
                                      "$error",
                                      duration: Duration(seconds: 5),
                                      colorText: Colors.red,
                                      snackPosition: SnackPosition.TOP,
                                    );
                                  }
                                }
                                setState(() {
                                  clicked = false;
                                });
                              },
                              child: Text("Register"),
                            ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Have an account?"),
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text("Login"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
