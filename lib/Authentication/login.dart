import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_svg/flutter_svg.dart';
import 'package:rating_and_comment/firebase_options.dart';
import 'package:rating_and_comment/mywebsite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey();
  final _emailcontroller = TextEditingController();
  final _passwordcontroler = TextEditingController();
  final white = Colors.white;
  final _passwordFocusNode = FocusNode();
  bool hidepassword = true;
  final outlineInputBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 100, 0, 20),
                      child: SvgPicture.asset(
                        'asset/images/Ayra_logo.svg',
                        semanticsLabel: "Ayra logo",
                        height: 70,
                        width: 70,
                      )),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "Let's log you in before you  \n change the word...",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: TextFormField(
                      controller: _emailcontroller,
                      autofocus: true,
                      onSaved: (newValue) {
                        debugPrint("UserName: $newValue");
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please Enter the Email";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_passwordFocusNode);
                      },
                      textInputAction: TextInputAction.next,
                      style: const TextStyle(color: Colors.black),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: "Email id",
                        border: outlineInputBorder,
                        hintStyle: const TextStyle(
                            color: Color.fromARGB(255, 136, 134, 134)),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.blueGrey[900],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: _passwordcontroler,
                    maxLines: 1,
                    obscureText: hidepassword,
                    focusNode: _passwordFocusNode,
                    onSaved: (newValue) {
                      debugPrint("Password:$newValue");
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter the password";
                      }
                      if (value.length < 4) {
                        return "Password should be geater than 4 characters";
                      }
                      return null;
                    },
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: "Password",
                      border: outlineInputBorder,
                      hintStyle: const TextStyle(
                          color: Color.fromARGB(255, 136, 134, 134)),
                      prefix: Icon(
                        Icons.lock_open_outlined,
                        color: Colors.blueGrey[900],
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(
                            () {
                              hidepassword = !hidepassword;
                            },
                          );
                        },
                        icon: Icon(
                          hidepassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 70,
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await Firebase.initializeApp(
                                options:
                                    DefaultFirebaseOptions.currentPlatform);
                            final email = _emailcontroller.text;
                            final password = _passwordcontroler.text;
                            final res = await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: email, password: password);
                            print(res);
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.elliptical(10, 10))),
                        ),
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 20),
                      child: const Text("or continue with")),
                  Row(
                    verticalDirection: VerticalDirection.down,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(10, 10))),
                              ),
                              child: SvgPicture.asset(
                                'asset/images/Facebook.svg',
                                height: 50,
                                width: 50,
                              )),
                        ),
                      ),
                      SizedBox(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () async {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(10, 10))),
                              ),
                              child: SvgPicture.asset(
                                'asset/images/Twitter.svg',
                                height: 50,
                                width: 50,
                              )),
                        ),
                      ),
                      SizedBox(
                        child: SizedBox(
                          height: 80,
                          width: 80,
                          child: ElevatedButton(
                              onPressed: () async {
                                try {
                                  GoogleSignIn googleSignIn =
                                      GoogleSignIn(scopes: ['email']);

                                  if (kIsWeb || Platform.isAndroid) {
                                    googleSignIn = GoogleSignIn(
                                      scopes: [
                                        'email',
                                      ],
                                    );
                                  }

                                  if (Platform.isIOS || Platform.isMacOS) {
                                    googleSignIn = GoogleSignIn(
                                      clientId:
                                          "1015927427902-v51lqig4g8j4l5ag6pg2agvgqoe5ed6j.apps.googleusercontent.com",
                                      scopes: [
                                        'email',
                                      ],
                                    );
                                  }
                                  final GoogleSignInAccount? googleAccount =
                                      await googleSignIn.signIn();

                                  print(googleAccount);

//If you want further information about Google accounts, such as authentication, use this.
                                  final GoogleSignInAuthentication
                                      googleAuthentication =
                                      await googleAccount!.authentication;

                                  print(googleAuthentication.idToken);
                                  print(googleAuthentication.accessToken);

                                  final idToken = googleAuthentication.idToken;
                                  final accessToken =
                                      googleAuthentication.accessToken;

                                  final queryParameters = {
                                    'access_secret': idToken ?? '',
                                    'access_token': accessToken ?? '',
                                  };
                                  var url = Uri.https(
                                      'api-dev.ayra.social',
                                      '/api/auth/google/callback',
                                      queryParameters);
                                  //print(url);
                                  //print(queryParameters.toString());
                                  final res = await http.get(url);
                                  Map<dynamic, dynamic> response =
                                      jsonDecode(res.body);
                                  print(response.keys);

                                  // ignore: use_build_context_synchronously
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyWebsite(res: response),
                                      ));
                                } catch (e) {
                                  debugPrint(e.toString());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(10, 10))),
                              ),
                              child: SvgPicture.asset(
                                'asset/images/Google.svg',
                                height: 50,
                                width: 50,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("New Here ?"),
                        TextButton(
                            onPressed: () async {},
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.amber[900]),
                            ))
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "By signing up you agree to our",
                        style: TextStyle(fontSize: 10),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Terms & Condition",
                            style: TextStyle(
                                color: Colors.amber[900], fontSize: 10),
                          )),
                      const Text("and", style: TextStyle(fontSize: 10)),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                                color: Colors.amber[900], fontSize: 10),
                          ))
                    ],
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
