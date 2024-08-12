import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';
import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';

/// An implementation of [DocumentScannerKitPlatform] that uses method channels.
class MethodChannelDocumentScannerKit extends DocumentScannerKitPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('document_scanner_kit');

  @override
  Future<List<String>?> scan() {
    return methodChannel.invokeListMethod<String>('scan');
  }
}
