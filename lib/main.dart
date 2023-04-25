import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import './screens/component/forgotpassword.dart';
import './screens/login_screens.dart';
// import './screens/component/authpage.dart';
import './screens/component/manager.dart';
import './provider/notification.dart';
import './screens/component/cart.dart';
import './screens/component/favorite.dart';
import './screens/component/notification.dart';
import './provider/favorite.dart';
import 'package:provider/provider.dart';

import './screens/overview_screens.dart';
import './screens/register_screen.dart';
// import './screens/login_screens.dart';
import './provider/products.dart';
import './screens/component/edit_product.dart';
import './screens/component/product_detail.dart';
import '../../provider/carts.dart';
import '../screens/component/home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Favorite(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Notifications(),
        ),
      ],
      child: MaterialApp(
        // navigatorKey: navigatorKey,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: MainPage(),
        routes: {
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          HomePage.routeName: (ctx) => HomePage(),
          ForgotPassword.routeName: (ctx) => ForgotPassword(),
          CartPage.routeName: (ctx) => CartPage(),
          FavoritePage.routeName: (ctx) => FavoritePage(),
          NotificationPage.routeName: (ctx) => NotificationPage(),
          OverviewScreens.routeName: (ctx) => OverviewScreens(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          ManagerPage.routeName: (ctx) => ManagerPage(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              // if (snapshot.connectionState == ConnectionState.waiting) {
              //   return Center(child: CircularProgressIndicator());
              // } else if (snapshot.hasError) {
              //   return Center(child: Text('Something went wrong'));
              // } else
              if (snapshot.hasData) {
                return HomePage();
              } else {
                return LoginScreens();
              }
            }),
      );
}
