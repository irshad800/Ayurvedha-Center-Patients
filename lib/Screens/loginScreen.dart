import 'package:doctor_booking/Provider/auth_provider.dart';
import 'package:doctor_booking/widgets/CustomButtom.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Custom_txtFeild.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    print(height);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Colors.white,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Stack(
                    children: [
                      Image.asset("assets/images/Frame 176.png"),
                      Positioned(
                          top: 60,
                          right: 140,
                          child: Image.asset("assets/images/Asset 1 2.png"))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Login Or Register To Book Your Appoinments',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        SizedBox(height: 30),

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text("  Email")),
                        custom_textfeild(
                          hinText: "Enter Your Email",
                          controller: _emailController,
                        ),

                        SizedBox(height: 20),

                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "  Enter Password",
                              style: TextStyle(fontFamily: "Airbnb"),
                            )),

                        custom_textfeild(
                          hinText: "Enter Password",
                          controller: _passwordController,
                        ),
                        // Recovery Password

                        SizedBox(height: 80),

                        // Sign In Button
                        Consumer<AuthProvider>(
                          builder: (context, value, child) => value.loading
                              ? CircularProgressIndicator()
                              : CustomButton(
                                  onPressed: () {
                                    if (_formkey.currentState?.validate() ??
                                        false) {
                                      value.login(
                                          username: _emailController.text,
                                          password: _passwordController.text,
                                          context: context);
                                    }
                                  },
                                  name: 'Login',
                                ),
                        ),

                        SizedBox(
                          height: 60,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                                'By creating or logging into an account you are agreeing with our ',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Terms and Conditions',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    // Handle Terms and Conditions tap
                                  },
                              ),
                              TextSpan(
                                text: ' and ',
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Colors.blue),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: '.',
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                        )
                        // Sign Up Text
                      ],
                    ),
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
