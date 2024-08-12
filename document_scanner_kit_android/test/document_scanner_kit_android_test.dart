import 'package:document_scanner_kit_android/document_scanner_kit_android.dart';
import 'package:document_scanner_kit_platform_interface/document_scanner_kit_platform_interface.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DocumentScannerKitAndroid', () {
    const kScanResult = ['path1', 'path2'];
    late DocumentScannerKitAndroid documentScannerKit;
    late List<MethodCall> log;

    setUp(() async {
      documentScannerKit = DocumentScannerKitAndroid();

      log = <MethodCall>[];
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(documentScannerKit.methodChannel,
              (methodCall) async {
        log.add(methodCall);
        switch (methodCall.method) {
          case 'scan':
            return kScanResult;
          default:
            return null;
        }
      });
    });

    test('can be registered', () {
      DocumentScannerKitAndroid.registerWith();
      expect(DocumentScannerKitPlatform.instance,
          isA<DocumentScannerKitAndroid>());
    });

    test('scan returns correct paths', () async {
      final result = await documentScannerKit.scan();
      expect(
        log,
        <Matcher>[isMethodCall('scan', arguments: null)],
      );
      expect(result, equals(kScanResult));
    });
  });
}
