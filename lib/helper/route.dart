import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tic_tac_toe/binding/binding.dart';

import '../view/homepage.dart';

class RouteHelper{

  static const String homepage = '/homepage';
  static String getHomePage() => '$homepage';

  static List<GetPage> routes =[
    GetPage(name: homepage, page: () => HomePage(),
    binding: Binding()),
  ];
}