import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/products.dart';
import '../../widget/display_product.dart';

enum FilterOptions {
  SignOut,
}

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _signOut = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          child: Text(
            'Home Page',
            textAlign: TextAlign.center,
          ),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.more_vert,
            ),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Sign out'),
                value: FilterOptions.SignOut,
              ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 20,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      width: double.infinity,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 68, 123, 182),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text.rich(
                        TextSpan(
                          text: 'Black Friday\n',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                          children: [
                            TextSpan(
                                text: 'Cashback 20%',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Special for you',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SizedBox(
                                width: 280,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 300.0,
                                        width: 300.0,
                                        child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQurZMhowkixgUaJVq_roMMRgUpjmwnQr-ZYQ&usqp=CAU',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: SizedBox(
                                width: 280,
                                height: 120,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: 300.0,
                                        width: 300.0,
                                        child: Image.network(
                                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROc6WHZT9Ew_QljJqWPNO6-cv7rn3ViMQm7A&usqp=CAU',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 40),
                                        child: Text.rich(
                                          TextSpan(children: [
                                            TextSpan(
                                              text: 'Shopping cart\n',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                            TextSpan(
                                              text: 'Brand',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   width: double.infinity,
                    //   child: RawMaterialButton(
                    //     fillColor: Colors.blue,
                    //     onPressed: () => FirebaseAuth.instance.signOut(),
                    //     // () {
                    //     //   Navigator.pushReplacement(
                    //     //     context,
                    //     //     MaterialPageRoute<void>(
                    //     //       builder: (BuildContext context) => OverviewScreens(),
                    //     //     ),
                    //     //   );
                    //     // },
                    //     elevation: 0.0,
                    //     padding: EdgeInsets.symmetric(vertical: 20.0),
                    //     shape: RoundedRectangleBorder(
                    //         borderRadius: BorderRadius.circular(15)),
                    //     child: Text(
                    //       'Sign Out',
                    //       style: TextStyle(color: Colors.white, fontSize: 20),
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: AspectRatio(
                                  aspectRatio: 1.02,
                                  child: DisplayProduct(),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
