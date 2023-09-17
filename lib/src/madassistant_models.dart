enum ConnectionManagerState {
  none,
  connecting,
  connected,
  disconnecting,
  disconnected,
}

class NetworkCallLogModel {
  NetworkCallLogModel({
    this.options,
    this.request,
    this.response,
    this.exception,
  });

  Options? options;

  Request? request;

  Response? response;

  ExceptionModel? exception;

  Object encode() {
    return <Object?>[
      options?.encode(),
      request?.encode(),
      response?.encode(),
      exception?.encode(),
    ];
  }

  static NetworkCallLogModel decode(Object result) {
    result as List<Object?>;
    return NetworkCallLogModel(
      options: result[0] != null
          ? Options.decode(result[0]! as List<Object?>)
          : null,
      request: result[1] != null
          ? Request.decode(result[1]! as List<Object?>)
          : null,
      response: result[2] != null
          ? Response.decode(result[2]! as List<Object?>)
          : null,
      exception: result[3] != null
          ? ExceptionModel.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class Options {
  Options({
    this.threadName,
    this.connectTimeoutMillis,
    this.readTimeoutMillis,
    this.writeTimeoutMillis,
    this.protocol,
    this.handshake,
  });

  String? threadName;

  int? connectTimeoutMillis;

  int? readTimeoutMillis;

  int? writeTimeoutMillis;

  String? protocol;

  Handshake? handshake;

  Object encode() {
    return <Object?>[
      threadName,
      connectTimeoutMillis,
      readTimeoutMillis,
      writeTimeoutMillis,
      protocol,
      handshake?.encode(),
    ];
  }

  static Options decode(Object result) {
    result as List<Object?>;
    return Options(
      threadName: result[0] as String?,
      connectTimeoutMillis: result[1] as int?,
      readTimeoutMillis: result[2] as int?,
      writeTimeoutMillis: result[3] as int?,
      protocol: result[4] as String?,
      handshake: result[5] != null
          ? Handshake.decode(result[5]! as List<Object?>)
          : null,
    );
  }
}

class Handshake {
  Handshake({
    this.protocolVersion,
    this.cipherSuite,
  });

  String? protocolVersion;

  String? cipherSuite;

  Object encode() {
    return <Object?>[
      protocolVersion,
      cipherSuite,
    ];
  }

  static Handshake decode(Object result) {
    result as List<Object?>;
    return Handshake(
      protocolVersion: result[0] as String?,
      cipherSuite: result[1] as String?,
    );
  }
}

class Request {
  Request({
    required this.method,
    required this.url,
    this.headers,
    required this.timestamp,
    this.contentType,
    this.body,
  });

  String method;

  String url;

  List<Map<String?, String?>?>? headers;

  int timestamp;

  String? contentType;

  String? body;

  Object encode() {
    return <Object?>[
      method,
      url,
      headers,
      timestamp,
      contentType,
      body,
    ];
  }

  static Request decode(Object result) {
    result as List<Object?>;
    return Request(
      method: result[0]! as String,
      url: result[1]! as String,
      headers: (result[2] as List<Object?>?)?.cast<Map<String?, String?>?>(),
      timestamp: result[3]! as int,
      contentType: result[4] as String?,
      body: result[5] as String?,
    );
  }
}

class Response {
  Response({
    this.headers,
    this.statusCode,
    required this.timestamp,
    this.gzippedLength,
    this.length,
    this.contentType,
    this.body,
  });

  List<Map<String?, String?>?>? headers;

  int? statusCode;

  int timestamp;

  int? gzippedLength;

  int? length;

  String? contentType;

  String? body;

  Object encode() {
    return <Object?>[
      headers,
      statusCode,
      timestamp,
      gzippedLength,
      length,
      contentType,
      body,
    ];
  }

  static Response decode(Object result) {
    result as List<Object?>;
    return Response(
      headers: (result[0] as List<Object?>?)?.cast<Map<String?, String?>?>(),
      statusCode: result[1] as int?,
      timestamp: result[2]! as int,
      gzippedLength: result[3] as int?,
      length: result[4] as int?,
      contentType: result[5] as String?,
      body: result[6] as String?,
    );
  }
}

class ExceptionModel {
  ExceptionModel({
    required this.exceptionThreadName,
    required this.crash,
    this.type,
    this.message,
    this.throwableMessage,
    this.data,
    required this.stackTrace,
    this.threads,
  });

  String exceptionThreadName;

  bool crash;

  String? type;

  String? message;

  String? throwableMessage;

  Map<String?, Object?>? data;

  List<ExceptionStacktraceLineModel?> stackTrace;

  Map<String?, List<ExceptionStacktraceLineModel?>?>? threads;

  Object encode() {
    return <Object?>[
      exceptionThreadName,
      crash,
      type,
      message,
      throwableMessage,
      data,
      stackTrace,
      threads,
    ];
  }

  static ExceptionModel decode(Object result) {
    result as List<Object?>;
    return ExceptionModel(
      exceptionThreadName: result[0]! as String,
      crash: result[1]! as bool,
      type: result[2] as String?,
      message: result[3] as String?,
      throwableMessage: result[4] as String?,
      data: (result[5] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      stackTrace: (result[6] as List<Object?>?)!.cast<ExceptionStacktraceLineModel?>(),
      threads: (result[7] as Map<Object?, Object?>?)?.cast<String?, List<ExceptionStacktraceLineModel?>?>(),
    );
  }
}

class ExceptionStacktraceLineModel {
  ExceptionStacktraceLineModel({
    required this.className,
    this.fileName,
    required this.nativeMethod,
    required this.methodName,
    required this.lineNumber,
  });

  String className;

  String? fileName;

  bool nativeMethod;

  String methodName;

  int lineNumber;

  Object encode() {
    return <Object?>[
      className,
      fileName,
      nativeMethod,
      methodName,
      lineNumber,
    ];
  }

  static ExceptionStacktraceLineModel decode(Object result) {
    result as List<Object?>;
    return ExceptionStacktraceLineModel(
      className: result[0]! as String,
      fileName: result[1] as String?,
      nativeMethod: result[2]! as bool,
      methodName: result[3]! as String,
      lineNumber: result[4]! as int,
    );
  }
}