import 'package:chatapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Logout() async {
    final storage = new FlutterSecureStorage();
    await storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Login(),
      ),
    );
  }

  checkToken() async {
    final storage = new FlutterSecureStorage();
    String? token = await storage.read(key: 'token');

    if (token == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    }
  }

  @override
  void initState() {
    checkToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Talkative",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.logout_outlined),
            color: Colors.white,
            onPressed: () {
              setState(() {
                Logout();
              });
            },
          )
        ],
      ),
      body: Container(
        child: Container(
          color: Colors.deepOrange,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              
            ],
          ),
        ),
      ),
    );
  }
}
