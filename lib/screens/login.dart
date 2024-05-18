import 'dart:convert';

import 'package:chatapp/screens/home.dart';
import 'package:chatapp/screens/signup.dart';
import 'package:chatapp/utils/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

final secureStorage = SecureStorage();

bool isLoading = false;
String phone = '';
String password = '';

void _handleLogin(BuildContext context) async {
  isLoading = true;
  final String url =
      'https://chat-app-backend-production-13ff.up.railway.app/login';
  final Map<String, String> headers = {
    "Content-Type": "application/json;charset=utf-8",
  };

  final Map<String, dynamic> body = {"phone": phone, "password": password};
  final jsonBody = json.encode(body);
  Uri uri = Uri.parse(url);

  try {
    final response = await http.post(uri, headers: headers, body: jsonBody);
    if (response.statusCode == 200) {
      final res = await json.decode(response.body);
      print('Success');

      secureStorage.write(res['token'], res['id']);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
      Fluttertoast.showToast(
        msg: "Login Successfully",
      );
      isLoading = false;
    } else {
      Fluttertoast.showToast(
        msg: "Login Failed",
      );
      print('failed');
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: "errrrrr .......${e}",
    );
    isLoading = true;

    print(e);
  }
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.indigo),
                    child: Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "Enter your Phone-number and password",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black54,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  // color: Colors.blueGrey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        onChanged: (query) {
                          setState(() {
                            phone = query;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "e.g : 03xx xxxxxxxx",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38)),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Container(
                  // color: Colors.blueGrey[50],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextFormField(
                        onChanged: (query) {
                          setState(() {
                            password = query;
                          });
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                            hintText: "e.g : we34wf7wfjewf4u",
                            hintStyle: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: Colors.black38)),
                      ),
                      SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
                Text(
                  'Forgot Password?',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _handleLogin(context);
                        });
                      },
                      child: Text('Log In'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.indigo,
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        textStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        child: Text(
                          'Signup ',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.indigo),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
