import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';

DocumentScannerKitPlatform get _platform => DocumentScannerKitPlatform.instance;

/// Starts the document scanner.
Future<List<String>?> scan() async {
  final scannedDocuments = await _platform.scan();
  return scannedDocuments;
}
