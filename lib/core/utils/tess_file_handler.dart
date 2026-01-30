import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class TessFileHandler {
  /// Copies the 'ara.traineddata' from assets to the application's document directory.
  /// Returns the path to the directory containing the 'tessdata' folder.
  static Future<String> ensureLanguageFileExists() async {
    try {
      // 1. Get the Application Documents Directory
      // This is a writable path on the device.
      final Directory appDir = await getApplicationDocumentsDirectory();

      // 2. Define the target path: .../app_documents/tessdata/ara.traineddata
      final String tessDataPath = path.join(appDir.path, 'tessdata');
      final Directory tessDataDir = Directory(tessDataPath);

      // Create the 'tessdata' folder if it doesn't exist
      if (!await tessDataDir.exists()) {
        await tessDataDir.create(recursive: true);
      }

      final String filePath = path.join(tessDataPath, 'ara.traineddata');
      final File file = File(filePath);

      // 3. Check if the file already exists locally
      if (!await file.exists()) {
        // Load the bytes from the asset bundle (declared in pubspec.yaml)
        final ByteData data = await rootBundle.load(
          'assets/tessdata/ara.traineddata',
        );

        final List<int> bytes = data.buffer.asUint8List(
          data.offsetInBytes,
          data.lengthInBytes,
        );

        // Write the bytes to the local file
        await file.writeAsBytes(bytes);
      }

      // Return the root path (Tesseract typically looks for 'tessdata' inside this path)
      return appDir.path;
    } catch (e) {
      // Explicitly throw so the Service knows initialization failed
      throw Exception('Failed to copy language file: $e');
    }
  }
}
