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

class _MyAppState extends State<MyApp> implements MADAssistantCallback {
  MADAssistant? _client;
  ConnectionManagerState _connectionState = ConnectionManagerState.none;
  int? _sessionId;

  @override
  void initState() {
    super.initState();
    _client = MADAssistant();
    _client?.init("test");
    MADAssistantCallback.setup(this);
  }

  @override
  void dispose() {
    MADAssistantCallback.setup(null);
    _client = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MADAssistant Flutter Test'),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            /// Connection Button
            ElevatedButton(
              onPressed: switch (_connectionState) {
                ConnectionManagerState.connecting || ConnectionManagerState.disconnecting => null,
                ConnectionManagerState.connected => () => _client?.disconnect(),
                _ => () => _client?.connect()
              },
              child: Text(switch (_connectionState) {
                ConnectionManagerState.connecting => "Connecting",
                ConnectionManagerState.disconnecting => "Disconnecting",
                ConnectionManagerState.connected => "Disconnect",
                _ => "Connect"
              }),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_sessionId != null) {
                  _client?.endSession();
                } else {
                  _client?.startSession();
                }
              },
              child: Text(_sessionId != null ? "End Session" : "Start Session"),
            ),
            const SizedBox(height: 64),
            ElevatedButton(onPressed: _logAnalyticsCall, child: const Text("Analytics Call"))
          ],
        ),
      ),
    );
  }

  void _logAnalyticsCall() {
    _client?.logAnalyticsEvent(
      "Destination 1",
      "test_event",
      {
        "string": "value1",
        "bool": true,
        "int": 1,
        "double": 2.35,
        "object": {
          "string": "value1",
          "bool": true,
          "int": 1,
          "double": 2.35,
        },
        "list": [
          {
            "string": "value1",
            "bool": true,
            "int": 1,
            "double": 2.35,
          },
        ]
      },
    );
  }

  @override
  void logDebug(String tag, String message) {
    debugPrint("(DEBUG) $tag: $message");
  }

  @override
  void logError(Object throwable) {
    debugPrint("(ERROR) $throwable");
  }

  @override
  void logInfo(String tag, String message) {
    debugPrint("(INFO) $tag: $message");
  }

  @override
  void logVerbose(String tag, String message) {
    debugPrint("(VERBOSE) $tag: $message");
  }

  @override
  void logWarn(String tag, String message) {
    debugPrint("(WARN) $tag: $message");
  }

  @override
  void onConnectionStateChanged(ConnectionManagerState state) {
    setState(() => _connectionState = state);
  }

  @override
  void onDisconnected(int code, String message) {
    debugPrint("onDisconnected: code: $code message: $message");
  }

  @override
  void onSessionEnded(int sessionId) {
    debugPrint("onSessionEnded: $sessionId");
    setState(() {
      _sessionId = sessionId;
    });
  }

  @override
  void onSessionStarted(int sessionId) {
    debugPrint("onSessionStarted: $sessionId");
    setState(() {
      _sessionId = null;
    });
  }
}
