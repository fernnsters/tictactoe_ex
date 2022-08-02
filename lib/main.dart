import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'helper/route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return  GetMaterialApp(
      title: "TicTacToe",
      debugShowCheckedModeBanner: false,
      initialRoute: RouteHelper.homepage,
       getPages: RouteHelper.routes,
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}

