import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'features/authentication/screens/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(home: LoginPage());
  }
}
