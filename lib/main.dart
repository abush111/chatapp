import 'dart:convert';
import 'dart:developer';
import 'dart:ui';

import 'package:chatapp/Page/Client/client.dart';
import 'package:chatapp/Page/chatroma/chatroma.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:pusher_client/pusher_client.dart';

Future<void> main() async {
  runApp(MyApp());
  await FlutterConfig.loadEnvVariables();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat UI',
      debugShowCheckedModeBanner: false,
      home: ChatRoom(),
    );
  }
}


