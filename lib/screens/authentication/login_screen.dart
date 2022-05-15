import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:provider/provider.dart';
import 'package:weight_tracker_app/screens/authentication/register_screen.dart';
import 'package:weight_tracker_app/screens/home_screen.dart';

import '../../providers/auth_provider.dart';
import 'login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool _passwordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Center(
        child: Form(
          key: _formKey,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Lottie.asset("assets/lottie_animation_files/weight.json",
                  repeat: true, reverse: true, animate: true),
              const SizedBox(height: 20),
              const Text(
                "Account Login",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    letterSpacing: 0),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24),
                child: TextFormField(
                  controller: _emailController,
                  style: const TextStyle(
                      letterSpacing: 0.1,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                    hintText: "Email Address",
                    hintStyle: TextStyle(
                        letterSpacing: 0.1,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.2)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2)),
                    prefixIcon: Icon(
                      Icons.email,
                      size: 22,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                  validator: (val) => val == null || !val.contains("@")
                      ? "Enter valid email address"
                      : null,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _passwordVisible,
                  style: const TextStyle(
                      letterSpacing: 0.1,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(
                        letterSpacing: 0.1,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500),
                    hintText: "Password",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide(color: Colors.grey, width: 1.2)),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide:
                            BorderSide(color: Colors.black, width: 1.2)),
                    prefixIcon: const Icon(
                      Icons.lock,
                      size: 22,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      child: Icon(
                        _passwordVisible
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        size: 22,
                      ),
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (val) => val!.length < 6
                      ? "Password must be atleast 6 Characters"
                      : null,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text(
                  "Login",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5),
                ),
                onPressed: () {
                  _submit();
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                errorMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      "Dont have an account? Register",
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _submit() async {
    final form = _formKey.currentState;
    if (!form!.validate()) {
      return;
    }

    final AuthProvider provider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      await provider.signInUser(
          _emailController.text, _passwordController.text);
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } catch (error) {
      setState(() {
        errorMessage = error.toString().replaceAll('Exception:', "");
      });
    }
  }
}
