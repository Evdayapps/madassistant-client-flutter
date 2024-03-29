// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

import 'madassistant_models.dart';

class _MADAssistantCodec extends StandardMessageCodec {
  const _MADAssistantCodec();

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

class MADAssistant {
  /// Constructor for [MADAssistant].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  MADAssistant({BinaryMessenger? binaryMessenger}) : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _MADAssistantCodec();

  /// Initialise a new instance of MADAssistant
  Future<void> init(String arg_passphrase) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.init', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_passphrase]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> connect() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.connect', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> disconnect() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.disconnect', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<ConnectionManagerState> getConnectionState() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.getConnectionState', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return ConnectionManagerState.values[replyList[0]! as int];
    }
  }

  Future<void> startSession() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.startSession', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> endSession() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.endSession', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<bool> hasActiveSession() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.hasActiveSession', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as bool?)!;
    }
  }

  Future<void> logCrashes() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logCrashes', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> logNetworkCall(NetworkCallLogModel arg_data) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logNetworkCall', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[arg_data]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> logCrashReport(ExceptionModel arg_exception) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logCrashReport', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[arg_exception]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> logAnalyticsEvent(
      String arg_destination, String arg_eventName, Map<Object?, Object?>? arg_data) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logAnalyticsEvent', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_destination, arg_eventName, arg_data]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> logGenericLog(
      int arg_type, String arg_tag, String arg_message, Map<Object?, Object?>? arg_data) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logGenericLog', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_type, arg_tag, arg_message, arg_data]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> logException(ExceptionModel arg_exception) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.madassistant.MADAssistant.logException', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList = await channel.send(<Object?>[arg_exception]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}
