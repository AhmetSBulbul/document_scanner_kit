import 'package:document_scanner_kit_platform_interface/src/method_channel_document_scanner_kit.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

/// The interface that implementations of document_scanner_kit must implement.
///
/// Platform implementations should extend this class
/// rather than implement it as `DocumentScannerKit`.
/// Extending this class (using `extends`) ensures that the subclass will get
/// the default implementation, while platform implementations that `implements`
///  this interface will be broken by newly added [DocumentScannerKitPlatform] methods.
abstract class DocumentScannerKitPlatform extends PlatformInterface {
  /// Constructs a DocumentScannerKitPlatform.
  DocumentScannerKitPlatform() : super(token: _token);

  static final Object _token = Object();

  static DocumentScannerKitPlatform _instance =
      MethodChannelDocumentScannerKit();

  /// The default instance of [DocumentScannerKitPlatform] to use.
  ///
  /// Defaults to [MethodChannelDocumentScannerKit].
  static DocumentScannerKitPlatform get instance => _instance;

  /// Platform-specific plugins should set this with their own platform-specific
  /// class that extends [DocumentScannerKitPlatform] when they register themselves.
  static set instance(DocumentScannerKitPlatform instance) {
    PlatformInterface.verify(instance, _token);
    _instance = instance;
  }

  /// Start the document scanner.
  ///
  /// The scanner will be started and the user will be able to scan a document.
  /// Returns the paths of the scanned document.
  Future<List<String>?> scan();
}
