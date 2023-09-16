import 'dart:async';

import 'package:flutter/material.dart';
import 'package:madassistant_flutter/madassistant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  MADAssistant? client;

  @override
  void initState() {
    super.initState();
    client = MADAssistant();
    client?.init("test");
    MADAssistantCallback.setup(MADAssistantCallbackImpl());
  }

  @override
  void dispose() {
    MADAssistantCallback.setup(null);
    client = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: [
            ElevatedButton(
              onPressed: () => client?.connect(),
              child: const Text("Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
