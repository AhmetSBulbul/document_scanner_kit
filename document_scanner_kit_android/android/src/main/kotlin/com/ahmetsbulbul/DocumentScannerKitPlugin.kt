package com.ahmetsbulbul

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodChannel

class DocumentScannerKitPlugin : FlutterPlugin, ActivityAware {
    private lateinit var handler: DocumentScannerKitHandler
    private lateinit var channel: MethodChannel
    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        handler = DocumentScannerKitHandler()
        channel = MethodChannel(binding.binaryMessenger, "document_scanner_kit_android")
        channel.setMethodCallHandler(handler)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        handler.setActivityPluginBinding(binding)
    }

    override fun onDetachedFromActivityForConfigChanges() {}

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}

    override fun onDetachedFromActivity() {}
}


