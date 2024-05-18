import 'dart:io';

import 'package:chatapp/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? token;
  String? id;
  IO.Socket? socket;

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

  @override
  void initState() {
    // initSocket();
    super.initState();
  }

  initSocket() {
    socket = IO.io("", <String, dynamic>{
      'autoConnect': false,
      'transports': ['websocket'],
    });
    socket?.connect();
    socket?.onConnect((_) {
      print('Connection established');
    });
    socket?.onDisconnect((_) => print('Connection Disconnection'));
    socket?.onConnectError((err) => print(err));
    socket?.onError((err) => print(err));
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
        // color: Colors.deepOrange,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextFormField(
                onChanged: (query) {
                  setState(() {});
                },
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Contact",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.black,
                    size: 28,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
