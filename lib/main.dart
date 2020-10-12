import 'package:flutter/material.dart';
import 'package:eRestaurant/src/providers/app.dart';
import 'package:eRestaurant/src/providers/category.dart';
import 'package:eRestaurant/src/providers/product.dart';
import 'package:eRestaurant/src/providers/promotion.dart';
import 'package:eRestaurant/src/providers/user.dart';
import 'package:eRestaurant/src/screens/home.dart';
import 'package:eRestaurant/src/screens/login.dart';
import 'package:eRestaurant/src/screens/splash.dart';
import 'package:eRestaurant/src/widgets/loading.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: PromotionProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
