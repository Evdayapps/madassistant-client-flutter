import 'package:pigeon/pigeon.dart';

enum ConnectionManagerState { none, connecting, connected, disconnecting, disconnected }

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/madassistant.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/evdayapps/madassistant_flutter/madassistant.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Runner/Madassistant.g.swift',
  swiftOptions: SwiftOptions(),
  //copyrightHeader: 'pigeons/copyright.txt',
  dartPackageName: 'madassistant',
))
@HostApi()
abstract class MADAssistant {
  /// Initialise a new instance of MADAssistant
  @async
  void init(String passphrase);

  // region Connection
  @async
  void connect();

  @async
  void disconnect();

  @async
  ConnectionManagerState getConnectionState();

  // endregion Connection Related

  @async
  void startSession();

  @async
  void endSession();

  @async
  bool hasActiveSession();

  @async
  void logCrashes();

  @async
  void logNetworkCall(NetworkCallLogModel data);

  @async
  void logCrashReport(Object throwable, String? message, Map? data);

  @async
  void logAnalyticsEvent(String destination, String eventName, Map data);

  @async
  void logGenericLog(int type, String tag, String message, Map? data);

  @async
  void logException(Object throwable, String? message, Map<String, dynamic>? data);
}

class NetworkCallLogModel {
  Options? options;
  Request? request;
  Response? response;
  ExceptionModel? exception;

  NetworkCallLogModel({
    this.options,
    this.request,
    this.response,
    this.exception,
  });
}

class Options {
  String? threadName;
  int? connectTimeoutMillis;
  int? readTimeoutMillis;
  int? writeTimeoutMillis;
  String? protocol;
  Handshake? handshake;

  Options({
    this.threadName,
    this.connectTimeoutMillis,
    this.readTimeoutMillis,
    this.writeTimeoutMillis,
    this.protocol,
    this.handshake,
  });
}

class Handshake {
  String? protocolVersion;
  String? cipherSuite;

  Handshake({
    this.protocolVersion,
    this.cipherSuite,
  });
}

class Request {
  String method;
  String url;
  List<Map<String, String>?>? headers; // Changed from JSONArray to List<String>
  int timestamp;
  String? contentType;
  String? body;

  Request({
    required this.method,
    required this.url,
    this.headers,
    required this.timestamp,
    this.contentType,
    this.body,
  });
}

class Response {
  List<Map<String, String>?>? headers; // Changed from JSONArray to List<String>
  int? statusCode;
  int timestamp;
  int? gzippedLength;
  int? length;
  String? contentType;
  String? body;

  Response({
    this.headers,
    this.statusCode,
    required this.timestamp,
    this.gzippedLength,
    this.length,
    this.contentType,
    this.body,
  });
}

class ExceptionModel {
  final String exceptionThreadName;
  final bool crash;
  final String? type;
  final String? message;
  final String? throwableMessage;
  final Map<String?, Object?>? data;
  final List<ExceptionStacktraceLineModel?> stackTrace;

  //final ExceptionModel? cause;
  final Map<String?, List<ExceptionStacktraceLineModel?>?>? threads;

  ExceptionModel({
    required this.exceptionThreadName,
    required this.crash,
    this.type,
    this.message,
    this.throwableMessage,
    this.data,
    required this.stackTrace,
    //this.cause,
    this.threads,
  });
}

class ExceptionStacktraceLineModel {
  final String className;
  final String? fileName;
  final bool nativeMethod;
  final String methodName;
  final int lineNumber;

  ExceptionStacktraceLineModel({
    required this.className,
    this.fileName,
    required this.nativeMethod,
    required this.methodName,
    required this.lineNumber,
  });
}

@FlutterApi()
abstract class MADAssistantCallback {
  // Callback for when a new session is started
  // [sessionId] is the timestamp of the new session
  void onSessionStarted(int sessionId);

  // Callback for when an ongoing session is ended
  void onSessionEnded(int sessionId);

  // Callback to notify the listener that the state has changed
  void onConnectionStateChanged(ConnectionManagerState state);

  // Callback for when the connection is disconnected
  void onDisconnected(int code, String message);

  // Logging methods
  void logInfo(String tag, String message);

  void logVerbose(String tag, String message);

  void logDebug(String tag, String message);

  void logWarn(String tag, String message);

  void logError(Object throwable);
}
