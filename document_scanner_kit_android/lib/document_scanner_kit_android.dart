import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// The Android implementation of [DocumentScannerKitPlatform].
class DocumentScannerKitAndroid extends DocumentScannerKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('document_scanner_kit_android');

  /// Registers this class as the default instance of [DocumentScannerKitPlatform]
  static void registerWith() {
    DocumentScannerKitPlatform.instance = DocumentScannerKitAndroid();
  }

  @override
  Future<List<String>?> scan() {
    return methodChannel.invokeListMethod<String>('scan');
  }
}
