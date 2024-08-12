import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';

class DocumentScannerKitMock extends DocumentScannerKitPlatform {
  static const mockScanResult = ['path1', 'path2'];

  @override
  Future<List<String>?> scan() async => mockScanResult;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('DocumentScannerKitPlatformInterface', () {
    late DocumentScannerKitPlatform documentScannerKitPlatform;

    setUp(() {
      documentScannerKitPlatform = DocumentScannerKitMock();
      DocumentScannerKitPlatform.instance = documentScannerKitPlatform;
    });

    group('scan', () {
      test('returns correct paths', () async {
        expect(
          await DocumentScannerKitPlatform.instance.scan(),
          equals(DocumentScannerKitMock.mockScanResult),
        );
      });
    });
  });
}
