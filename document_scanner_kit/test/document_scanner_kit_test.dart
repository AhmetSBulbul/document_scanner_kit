import 'package:document_scanner_kit/document_scanner_kit.dart';
import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDocumentScannerKitPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements DocumentScannerKitPlatform {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DocumentScannerKit', () {
    late DocumentScannerKitPlatform documentScannerKitPlatform;

    setUp(() {
      documentScannerKitPlatform = MockDocumentScannerKitPlatform();
      DocumentScannerKitPlatform.instance = documentScannerKitPlatform;
    });

    group('scan', () {
      test('returns list with file paths when platform implementation exists',
          () async {
        const filePaths = ['file1', 'file2'];
        when(
          () => documentScannerKitPlatform.scan(),
        ).thenAnswer((_) async => filePaths);

        final actualResult = await scan();
        expect(actualResult, equals(filePaths));
      });
    });
  });
}
