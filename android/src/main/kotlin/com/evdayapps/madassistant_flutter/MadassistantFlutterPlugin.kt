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
import com.evdayapps.madassistant.common.models.networkcalls.Options
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler

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
            client = MADAssistantClientImpl(
                applicationContext = applicationContext!!,
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
                            madAssistantCallback?.onConnectionStateChanged(
                                stateArg = state.let {
                                    when (it) {
                                        ConnectionManager.State.None -> ConnectionManagerState.NONE
                                        ConnectionManager.State.Connecting -> ConnectionManagerState.CONNECTING
                                        ConnectionManager.State.Connected -> ConnectionManagerState.CONNECTED
                                        ConnectionManager.State.Disconnecting -> ConnectionManagerState.DISCONNECTING
                                        ConnectionManager.State.Disconnected -> ConnectionManagerState.DISCONNECTED
                                    }
                                },
                                callback = {}
                            )
                        }
                    }

                    override fun onDisconnected(code: Int, message: String) {
                        activity?.runOnUiThread {
                            madAssistantCallback?.onDisconnected(
                                codeArg = code.toLong(),
                                messageArg = message,
                                callback = {}
                            )
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
                            madAssistantCallback?.onSessionEnded(
                                sessionIdArg = sessionId,
                                callback = {}
                            )
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
                            madAssistantCallback?.onSessionStarted(
                                sessionIdArg = sessionId,
                                callback = {}
                            )
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
                        // TODO Convert this
                        activity?.runOnUiThread {
                            madAssistantCallback?.logError(
                                throwableArg = throwable,
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
        data: NetworkCallLogModel,
        callback: (Result<Unit>) -> Unit
    ) {
        client?.logNetworkCall(
            data = com.evdayapps.madassistant.common.models.networkcalls.NetworkCallLogModel(
                options = Options(
                    threadName = data.options?.threadName,
                    connectTimeoutMillis = data.options?.connectTimeoutMillis,

                )
            ),
        )
        client?.logAnalyticsEvent(
            destination = destination,
            eventName = eventName,
            data = data?.filterKeys { it != null } as? Map<String, Any?> ?: mapOf(),
        )
    }

    override fun logCrashReport(
        throwable: Any,
        message: String?,
        data: Map<Any, Any?>?,
        callback: (Result<Unit>) -> Unit
    ) {
        TODO("Not yet implemented")
    }

    override fun logAnalyticsEvent(
        destination: String,
        eventName: String,
        data: Map<String?, Any>?,
        callback: (Result<Unit>) -> Unit
    ) {
        client?.logAnalyticsEvent(
            destination = destination,
            eventName = eventName,
            data = data?.filterKeys { it != null } as? Map<String, Any?> ?: mapOf(),
        )
    }

    override fun logGenericLog(
        type: Long,
        tag: String,
        message: String,
        data: Map<String?, Any>?,
        callback: (Result<Unit>) -> Unit
    ) {
        client?.logGenericLog(
            type = type.toInt(),
            tag = tag,
            message = message,
            data = data?.filterKeys { it != null } as? Map<String, Any?> ?: mapOf(),
        )
    }

    override fun logException(
        throwable: Any,
        message: String?,
        data: Map<String, Any>?,
        callback: (Result<Unit>) -> Unit
    ) {
        TODO("Not yet implemented")
    }
}
