import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nairapay/Helpers/Utils.dart';
import 'package:nairapay/Pages/Home.dart';
import 'package:nairapay/Widget/Inputes.dart';

import '../Helpers/Constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _recEmailController = TextEditingController();

  bool isLoading = false;

  forgotPassword({required String email}) {
    bool loading = false;
    _recEmailController.text = email;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isDismissible: false,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (BuildContext context, setState) {
            return Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(
                  left: 10, right: 10, bottom: 10, top: 10),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Text(
                          " Forgot Password",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        "Enter your email for the verification process. We will send you a verification  email. Kindly follow to link to reset your password. Thank you.",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Inputes().TextInpute(
                        hint: "Email goes here", controller: _emailController),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var email__ = _emailController.text.trim();
                        if (email__.isNotEmpty) {
                          if (!ValidateEmail().isEmailValid(email)) {
                            Alart(
                                context: context,
                                message: "Please enter a valid email address",
                                isError: true);
                            return;
                          }
                        } else {
                          Alart(
                              context: context,
                              message: "Enter your email first",
                              isError: true);
                          return;
                        }

                        try {
                          setState(() {
                            loading = true;
                          });

                          Alart(
                              context: context,
                              message: "Sent!!",
                              isError: false);

                          setState(() {
                            loading = false;
                          });

                          Navigator.of(context).pop;
                          Navigator.of(context).pop;
                        } catch (e) {
                          Alart(
                              context: context,
                              message: "Something Went wrong!",
                              isError: true);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Text(
                          "   Get Reset Link   ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ]),
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.all(10),
                child: const Icon(Icons.info_rounded)),
          )
        ],
        title: const Text(
          "Back",
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 25),
                  child: const Text(
                    "Welcome Back!",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, top: 10, bottom: 20),
                  child: const Text(
                    "Sign in to your account",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
                Inputes().TextInpute(
                    hint: "Enter email", controller: _emailController),
                Inputes().TextInpute(
                    hint: "Enter password", controller: _passwordController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(""),
                    GestureDetector(
                      onTap: () {
                        var email_ = _emailController.text;
                        forgotPassword(email: email_);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 20, right: 15),
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    var email = _emailController.text.trim();
                    var password = _passwordController.text.trim();

                    if (email.isEmpty || password.isEmpty) {
                      Alart(
                          context: context,
                          message: "Please fill in email and password",
                          isError: false);
                      return;
                    }

                    if (!ValidateEmail().isEmailValid(email)) {
                      Alart(
                          context: context,
                          message: "Please enter a valid email address",
                          isError: false);
                      return;
                    }

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                        (route) => false);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: blue,
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    child: Text(
                      "   Login In   ",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RichText(
                    text: TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w600,
                                  color: blue,
                                  fontSize: 14),
                              recognizer: TapGestureRecognizer()..onTap = () {})
                        ]),
                  ),
                )
              ]),
        ),
      ]),
    );
  }
}
