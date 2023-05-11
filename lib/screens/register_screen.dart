import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import '../screens/login_screens.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final navigatorKey = GlobalKey<NavigatorState>();
  final formKey = GlobalKey<FormState>();

  final _formFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _formFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 70.0,
          ),
          child: Text(
            'Register Page',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15),
              Text(
                'Register',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 60),
              TextFormField(
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: _emailController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_formFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter gmail.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    prefixIcon: Icon(Icons.mail),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.blue),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.blue),
                      gapPadding: 10,
                    )),
              ),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                controller: _passwordController,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_formFocusNode);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter password.';
                  } else if (value.length < 6) {
                    return 'Please enter min 6 characters';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 45,
                      vertical: 20,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.blue),
                      gapPadding: 10,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28),
                      borderSide: BorderSide(color: Colors.blue),
                      gapPadding: 10,
                    )),
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Colors.blue,
                  onPressed: signOut,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signOut() async {
    // final isValid = formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
    // Navigator.of(context).pushNamed(LoginScreens.routeName);
    // Navigator.pop(context);
  }
}
