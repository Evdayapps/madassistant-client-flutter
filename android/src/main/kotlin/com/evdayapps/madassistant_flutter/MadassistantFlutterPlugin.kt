package com.evdayapps.madassistant_flutter

import ConnectionManagerState
import MADAssistant
import MADAssistantCallback
import NetworkCallLogModel
import android.app.Activity
import android.content.Context
import com.evdayapps.madassistant.clientlib.MADAssistantClient
import com.evdayapps.madassistant.clientlib.MADAssistantClientImpl
import com.evdayapps.madassistant.clientlib.connection.ConnectionManager
import com.evdayapps.madassistant.common.models.exceptions.ExceptionModel
import com.evdayapps.madassistant.common.models.exceptions.ExceptionStacktraceLineModel
import com.evdayapps.madassistant.common.models.networkcalls.Handshake
import com.evdayapps.madassistant.common.models.networkcalls.Options
import com.evdayapps.madassistant.common.models.networkcalls.Request
import com.evdayapps.madassistant.common.models.networkcalls.Response
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import org.json.JSONArray
import org.json.JSONObject
import ExceptionModel as FlutterExceptionModel
import ExceptionStacktraceLineModel as FlutterExceptionStacktraceLineModel

/** MadassistantPlugin */
class MadassistantFlutterPlugin : FlutterPlugin, MethodCallHandler, MADAssistant, ActivityAware {

    private var activity: Activity? = null
    private var applicationContext: Context? = null
    private var client: MADAssistantClient? = null
    private var madAssistantCallback: MADAssistantCallback? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        MADAssistant.setUp(flutterPluginBinding.binaryMessenger, this)
        madAssistantCallback = MADAssistantCallback(flutterPluginBinding.binaryMessenger)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        TODO("Not yet implemented")
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        madAssistantCallback = null
        applicationContext = null
        MADAssistant.setUp(binding.binaryMessenger, null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    /** Initialise a new instance of MADAssistant */
    override fun init(passphrase: String, callback: (Result<Unit>) -> Unit) {
        if (client == null) {
            client = MADAssistantClientImpl(applicationContext = applicationContext!!,
                passphrase = passphrase,
                callback = object : MADAssistantClient.Callback {
                    /**
                     * Callback to notify the listener that the state has changed
                     */
                    /**
                     * Callback to notify the listener that the state has changed
                     */
                    override fun onConnectionStateChanged(state: ConnectionManager.State) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.onConnectionStateChanged(stateArg = state.let {
                                when (it) {
                                    ConnectionManager.State.None -> ConnectionManagerState.NONE
                                    ConnectionManager.State.Connecting -> ConnectionManagerState.CONNECTING
                                    ConnectionManager.State.Connected -> ConnectionManagerState.CONNECTED
                                    ConnectionManager.State.Disconnecting -> ConnectionManagerState.DISCONNECTING
                                    ConnectionManager.State.Disconnected -> ConnectionManagerState.DISCONNECTED
                                }
                            }, callback = {})
                        }
                    }

                    override fun onDisconnected(code: Int, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.onDisconnected(codeArg = code.toLong(),
                                messageArg = message,
                                callback = {})
                        }
                    }

                    /**
                     * Callback for when an ongoing session is ended
                     */
                    /**
                     * Callback for when an ongoing session is ended
                     */
                    override fun onSessionEnded(sessionId: Long) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.onSessionEnded(sessionIdArg = sessionId,
                                callback = {})
                        }
                    }

                    /**
                     * Callback for when a new session is started
                     *
                     * [sessionId] is the timestamp of the new session
                     */
                    /**
                     * Callback for when a new session is started
                     *
                     * [sessionId] is the timestamp of the new session
                     */
                    override fun onSessionStarted(sessionId: Long) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.onSessionStarted(sessionIdArg = sessionId,
                                callback = {})
                        }
                    }

                    override fun d(tag: String, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.logDebug(
                                tagArg = tag,
                                messageArg = message,
                                callback = {},
                            )
                        }
                    }

                    override fun e(throwable: Throwable) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.logError(
                                ExceptionModel(
                                    threadName = "",
                                    throwable = throwable,
                                    isCrash = false,
                                    message = throwable.message,
                                    data = null
                                ).toFlutterException(),
                                callback = {},
                            )
                        }
                    }

                    override fun i(tag: String, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.logInfo(
                                tagArg = tag,
                                messageArg = message,
                                callback = {},
                            )
                        }
                    }

                    override fun v(tag: String, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.logVerbose(
                                tagArg = tag,
                                messageArg = message,
                                callback = {},
                            )
                        }
                    }

                    override fun w(tag: String, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.logWarn(
                                tagArg = tag,
                                messageArg = message,
                                callback = {},
                            )
                        }
                    }
                })
        }
    }

    override fun connect(callback: (Result<Unit>) -> Unit) {
        client?.connect()
    }

    override fun disconnect(callback: (Result<Unit>) -> Unit) {
        client?.disconnect()
    }

    override fun getConnectionState(callback: (Result<ConnectionManagerState>) -> Unit) {
        callback(Result.success(client?.getConnectionState()?.let {
            when (it) {
                ConnectionManager.State.None -> ConnectionManagerState.NONE
                ConnectionManager.State.Connecting -> ConnectionManagerState.CONNECTING
                ConnectionManager.State.Connected -> ConnectionManagerState.CONNECTED
                ConnectionManager.State.Disconnecting -> ConnectionManagerState.DISCONNECTING
                ConnectionManager.State.Disconnected -> ConnectionManagerState.DISCONNECTED
            }
        } ?: ConnectionManagerState.NONE))
    }

    override fun startSession(callback: (Result<Unit>) -> Unit) {
        client?.startSession()
    }

    override fun endSession(callback: (Result<Unit>) -> Unit) {
        client?.endSession()
    }

    override fun hasActiveSession(callback: (Result<Boolean>) -> Unit) {
        callback(Result.success(client?.hasActiveSession() ?: false))
    }

    override fun logCrashes(callback: (Result<Unit>) -> Unit) {
        client?.logCrashes()
    }

    override fun logNetworkCall(
        data: NetworkCallLogModel, callback: (Result<Unit>) -> Unit
    ) {
        client?.logNetworkCall(
            data = com.evdayapps.madassistant.common.models.networkcalls.NetworkCallLogModel(
                options = data.options?.let {
                    Options(threadName = it.threadName,
                        connectTimeoutMillis = it.connectTimeoutMillis?.toInt(),
                        readTimeoutMillis = it.readTimeoutMillis?.toInt(),
                        writeTimeoutMillis = it.writeTimeoutMillis?.toInt(),
                        protocol = it.protocol,
                        handshake = it.handshake?.let {
                            Handshake(
                                protocolVersion = it.protocolVersion, cipherSuite = it.cipherSuite
                            )
                        })
                },
                request = data.request?.let {
                    Request(
                        method = it.method,
                        timestamp = it.timestamp,
                        url = it.url,
                        contentType = it.contentType,
                        headers = it.headers?.filterNotNull()?.let { headers ->
                            when {
                                headers.isEmpty() -> null
                                else -> JSONArray().apply {
                                    headers.forEach { map ->
                                        put(JSONObject().apply {
                                            map.entries.forEach { entry ->
                                                this.put(entry.key, entry.value)
                                            }
                                        })
                                    }

                                }
                            }
                        },
                        body = it.body
                    )
                },
                response = data.response?.let {
                    Response(
                        timestamp = it.timestamp,
                        statusCode = it.statusCode?.toInt(),
                        length = it.length,
                        gzippedLength = it.gzippedLength,
                        contentType = it.contentType,
                        headers = it.headers?.filterNotNull()?.let { headers ->
                            when {
                                headers.isEmpty() -> null
                                else -> JSONArray().apply {
                                    headers.forEach { map ->
                                        put(JSONObject().apply {
                                            map.entries.forEach { entry ->
                                                this.put(entry.key, entry.value)
                                            }
                                        })
                                    }

                                }
                            }
                        },
                        body = it.body
                    )
                },
                exception = data.exception?.let {
                    mapExceptionModel(it)
                }
            ),
        )
    }

    override fun logCrashReport(
        exception: FlutterExceptionModel, callback: (Result<Unit>) -> Unit
    ) {
        TODO("Not yet implemented")
    }

    override fun logAnalyticsEvent(
        destination: String,
        eventName: String,
        data: Map<Any, Any?>?,
        callback: (Result<Unit>) -> Unit
    ) {
        client?.logAnalyticsEvent(
            destination = destination,
            eventName = eventName,
            data = data?.let { it as Map<String, Any?> } ?: mapOf()
        )
    }

    override fun logGenericLog(
        type: Long,
        tag: String,
        message: String,
        data: Map<Any, Any?>?,
        callback: (Result<Unit>) -> Unit
    ) {
        client?.logGenericLog(
            type = type.toInt(),
            tag = tag,
            message = message,
            data = data as? Map<String, Any?> ?: mapOf(),
        )
    }

    override fun logException(
        exception: FlutterExceptionModel, callback: (Result<Unit>) -> Unit
    ) {
        client?.logException(
            exception = mapExceptionModel(exception)
        )

    }


    private fun mapExceptionModel(it: FlutterExceptionModel): ExceptionModel = ExceptionModel(
        exceptionThreadName = it.exceptionThreadName,
        crash = it.crash,
        type = it.type,
        message = it.message,
        throwableMessage = it.throwableMessage,
        data = it.data
            ?.filter { list -> list.key != null }
            ?.takeIf { list -> list.isNotEmpty() }
            ?.let {
                JSONObject().apply {
                    it.entries.forEach { entry ->
                        this.put(entry.key!!, entry.value)
                    }
                }
            },
        stackTrace = it.stackTrace.let {
            it.filterNotNull().map {
                ExceptionStacktraceLineModel(
                    className = it.className,
                    fileName = it.fileName,
                    nativeMethod = it.nativeMethod,
                    methodName = it.methodName,
                    lineNumber = it.lineNumber.toInt()
                )
            }
        },
        cause = null,
        threads = it.threads?.let {
            it.filter { it.key != null }
                .map {
                    it.key!! to it.value!!.filterNotNull().map {
                        ExceptionStacktraceLineModel(
                            className = it.className,
                            fileName = it.fileName,
                            nativeMethod = it.nativeMethod,
                            methodName = it.methodName,
                            lineNumber = it.lineNumber.toInt()
                        )
                    }
                }.toMap()
        },
    )
}

fun FlutterExceptionModel.toKotlinExceptionModel(): ExceptionModel {
    return ExceptionModel(
        exceptionThreadName = this.exceptionThreadName,
        crash = this.crash,
        type = this.type,
        message = this.message,
        throwableMessage = this.throwableMessage,
        data = this.data
            ?.filter { list -> list.key != null }
            ?.takeIf { list -> list.isNotEmpty() }
            ?.let {
                JSONObject().apply {
                    it.entries.forEach { entry ->
                        this.put(entry.key!!, entry.value)
                    }
                }
            },
        stackTrace = this.stackTrace.let {
            it.filterNotNull().map {
                ExceptionStacktraceLineModel(
                    className = it.className,
                    fileName = it.fileName,
                    nativeMethod = it.nativeMethod,
                    methodName = it.methodName,
                    lineNumber = it.lineNumber.toInt()
                )
            }
        },
        cause = null,
        threads = this.threads?.let {
            it.filter { it.key != null }
                .map {
                    it.key!! to it.value!!.filterNotNull().map {
                        ExceptionStacktraceLineModel(
                            className = it.className,
                            fileName = it.fileName,
                            nativeMethod = it.nativeMethod,
                            methodName = it.methodName,
                            lineNumber = it.lineNumber.toInt()
                        )
                    }
                }.toMap()
        },
    )
}

fun ExceptionModel.toFlutterException(): FlutterExceptionModel {
    return FlutterExceptionModel(
        exceptionThreadName = this.exceptionThreadName,
        crash = this.crash,
        type = this.type,
        message = this.message,
        throwableMessage = this.throwableMessage,
        data = this.data?.takeIf { it.length() > 0 }?.let {
            val map = mutableMapOf<String, Any>()
            it.keys().forEach { key ->
                map.put(key, it[key])
            }
            map.toMap()
        },
        stackTrace = this.stackTrace.let {
            it.map {
                FlutterExceptionStacktraceLineModel(
                    className = it.className,
                    fileName = it.fileName,
                    nativeMethod = it.nativeMethod,
                    methodName = it.methodName,
                    lineNumber = it.lineNumber.toLong()
                )
            }
        },
        threads = this.threads?.map { entry ->
            entry.key to entry.value.map { item ->
                FlutterExceptionStacktraceLineModel(
                    className = item.className,
                    fileName = item.fileName,
                    nativeMethod = item.nativeMethod,
                    methodName = item.methodName,
                    lineNumber = item.lineNumber.toLong()
                )
            }
        }?.toMap(),
    )
}
