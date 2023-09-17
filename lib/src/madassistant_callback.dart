import 'package:flutter/services.dart';

import 'madassistant_models.dart';

class _MADAssistantCallbackCodec extends StandardMessageCodec {
  const _MADAssistantCallbackCodec();

  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is ExceptionModel) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is ExceptionStacktraceLineModel) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is Handshake) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is NetworkCallLogModel) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is Options) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is Request) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is Response) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return ExceptionModel.decode(readValue(buffer)!);
      case 129:
        return ExceptionStacktraceLineModel.decode(readValue(buffer)!);
      case 130:
        return Handshake.decode(readValue(buffer)!);
      case 131:
        return NetworkCallLogModel.decode(readValue(buffer)!);
      case 132:
        return Options.decode(readValue(buffer)!);
      case 133:
        return Request.decode(readValue(buffer)!);
      case 134:
        return Response.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class MADAssistantCallback {
  static const MessageCodec<Object?> codec = _MADAssistantCallbackCodec();

  void onSessionStarted(int sessionId);

  void onSessionEnded(int sessionId);

  void onConnectionStateChanged(ConnectionManagerState state);

  void onDisconnected(int code, String message);

  void logInfo(String tag, String message);

  void logVerbose(String tag, String message);

  void logDebug(String tag, String message);

  void logWarn(String tag, String message);

  void logError(Object throwable);

  static void setup(MADAssistantCallback? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionStarted', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionStarted was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_sessionId = (args[0] as int?);
          assert(arg_sessionId != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionStarted was null, expected non-null int.');
          api.onSessionStarted(arg_sessionId!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionEnded', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionEnded was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_sessionId = (args[0] as int?);
          assert(arg_sessionId != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onSessionEnded was null, expected non-null int.');
          api.onSessionEnded(arg_sessionId!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.onConnectionStateChanged', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onConnectionStateChanged was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final ConnectionManagerState? arg_state =
              args[0] == null ? null : ConnectionManagerState.values[args[0]! as int];
          assert(arg_state != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onConnectionStateChanged was null, expected non-null ConnectionManagerState.');
          api.onConnectionStateChanged(arg_state!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.onDisconnected', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onDisconnected was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final int? arg_code = (args[0] as int?);
          assert(arg_code != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onDisconnected was null, expected non-null int.');
          final String? arg_message = (args[1] as String?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.onDisconnected was null, expected non-null String.');
          api.onDisconnected(arg_code!, arg_message!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.logInfo', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logInfo was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_tag = (args[0] as String?);
          assert(arg_tag != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logInfo was null, expected non-null String.');
          final String? arg_message = (args[1] as String?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logInfo was null, expected non-null String.');
          api.logInfo(arg_tag!, arg_message!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.logVerbose', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logVerbose was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_tag = (args[0] as String?);
          assert(arg_tag != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logVerbose was null, expected non-null String.');
          final String? arg_message = (args[1] as String?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logVerbose was null, expected non-null String.');
          api.logVerbose(arg_tag!, arg_message!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.logDebug', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logDebug was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_tag = (args[0] as String?);
          assert(arg_tag != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logDebug was null, expected non-null String.');
          final String? arg_message = (args[1] as String?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logDebug was null, expected non-null String.');
          api.logDebug(arg_tag!, arg_message!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.logWarn', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logWarn was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final String? arg_tag = (args[0] as String?);
          assert(arg_tag != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logWarn was null, expected non-null String.');
          final String? arg_message = (args[1] as String?);
          assert(arg_message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logWarn was null, expected non-null String.');
          api.logWarn(arg_tag!, arg_message!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.madassistant.MADAssistantCallback.logError', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logError was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final Object? arg_throwable = (args[0] as Object?);
          assert(arg_throwable != null,
              'Argument for dev.flutter.pigeon.madassistant.MADAssistantCallback.logError was null, expected non-null Object.');
          api.logError(arg_throwable!);
          return;
        });
      }
    }
  }
}
