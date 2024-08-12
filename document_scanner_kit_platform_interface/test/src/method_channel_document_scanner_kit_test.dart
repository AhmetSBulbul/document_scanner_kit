import 'package:document_scanner_kit_platform_interface/src/method_channel_document_scanner_kit.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('$MethodChannelDocumentScannerKit', () {
    const kScanResult = ['path1', 'path2'];
    late MethodChannelDocumentScannerKit methodChannelDocumentScannerKit;
    final log = <MethodCall>[];

    setUp(() async {
      methodChannelDocumentScannerKit = MethodChannelDocumentScannerKit();
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(
        methodChannelDocumentScannerKit.methodChannel,
        (methodCall) async {
          log.add(methodCall);
          switch (methodCall.method) {
            case 'scan':
              return kScanResult;
            default:
              return null;
          }
        },
      );
    });

    tearDown(log.clear);

    test('scan returns correct paths', () async {
      final result = await methodChannelDocumentScannerKit.scan();
      expect(
        log,
        <Matcher>[isMethodCall('scan', arguments: null)],
      );
      expect(result, equals(kScanResult));
    });
  });
}
