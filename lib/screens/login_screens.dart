import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../screens/component/forgotpassword.dart';
import '../screens/register_screen.dart';

// import '../screens/overview_screens.dart';

class LoginScreens extends StatefulWidget {
  static const routeName = '/login';

  @override
  State<LoginScreens> createState() => _LoginScreensState();
}

class _LoginScreensState extends State<LoginScreens> {
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
          child: Text(
            'Login Page',
            textAlign: TextAlign.center,
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
              Text(
                'Welcome to E-commerce',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Sign in with your email and password \nor continue with social media',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 65),
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
              SizedBox(height: 45),
              Container(
                width: double.infinity,
                child: RawMaterialButton(
                  fillColor: Colors.blue,
                  onPressed: signIn,
                  elevation: 0.0,
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.black,
                height: 20,
                thickness: 0.8,
                indent: 0,
                endIndent: 0,
              ),
              SizedBox(height: 15),
              FloatingActionButton.extended(
                onPressed: signInWithGoogle,
                icon: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWKZ9OYF0vsfYHFdozFXWdr6VBqSxu7mdHa5izCN7HWw&s',
                  width: 28,
                  height: 28,
                  fit: BoxFit.cover,
                ),
                label: Text(
                  'Sign in with Google',
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(ForgotPassword.routeName);
                },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 80.0),
                child: Row(
                  children: [
                    Text(
                      'Don\'t have an account?',
                      style: TextStyle(fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(RegisterScreen.routeName);
                      },
                      child: Text(
                        'Register',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    // final isValid = formKey.currentState!.validate();
    // if (!isValid) {
    //   return;
    // }
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    // Navigator.of(context).pushNamed(HomePage.routeName);
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future<bool> signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? account = await googleSignIn.signIn();
      if (account == null) {
        return false;
      }
      UserCredential res = await FirebaseAuth.instance
          .signInWithCredential(GoogleAuthProvider.credential(
        idToken: (await account.authentication).idToken,
        accessToken: (await account.authentication).accessToken,
      ));
      if (res.user == null) {
        return false;
      }
      return true;
    } catch (e) {
      print(e);
      return false;
    }
    // Navigator.of(context).pushNamed(HomePage.routeName);
  }
}
