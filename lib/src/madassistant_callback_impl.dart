import 'package:flutter/cupertino.dart';
import 'package:madassistant_flutter/src/madassistant.g.dart';

class MADAssistantCallbackImpl extends MADAssistantCallback {
  @override
  Future<void> logDebug(String tag, String message) async {
    debugPrint("DEBUG: $tag\n$message");
  }

  @override
  Future<void> logError(Object throwable) {
    // TODO: implement logError
    throw UnimplementedError();
  }

  @override
  Future<void> logInfo(String tag, String message) async {
    debugPrint("INFO: $tag\n$message");
  }

  @override
  Future<void> logVerbose(String tag, String message) async {
    debugPrint("VERBOSE: $tag\n$message");
  }

  @override
  Future<void> logWarn(String tag, String message) async {
    debugPrint("WARD: $tag\n$message");
  }

  @override
  Future<void> onConnectionStateChanged(ConnectionManagerState state) async {
    debugPrint("onConnectionStateChanged: state: $state");
  }

  @override
  Future<void> onDisconnected(int code, String message) async {
    debugPrint("onDisconnected: ($code) $message");
  }

  @override
  Future<void> onSessionEnded(int sessionId) async {
    debugPrint("onSessionEnded: id: $sessionId");
  }

  @override
  Future<void> onSessionStarted(int sessionId) async {
    debugPrint("onSessionStarted: id: $sessionId");
  }
}
