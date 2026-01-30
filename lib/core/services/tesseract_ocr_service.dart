import 'package:injectable/injectable.dart';
import 'package:flutter_tesseract_ocr/flutter_tesseract_ocr.dart';
import '../utils/tess_file_handler.dart';

@lazySingleton
class TesseractOcrService {
  Future<String> extractText(String imagePath) async {
    try {
      // 1. Ensure the language file is ready
      await TessFileHandler.ensureLanguageFileExists();

      // 2. Execute OCR
      // language: 'ara' (Must match the filename ara.traineddata)
      // args: psm 6 is generally good for uniform blocks of text like invoices
      final String text = await FlutterTesseractOcr.extractText(
        imagePath,
        language: 'ara',
        args: {'psm': '6', 'preserve_interword_spaces': '1'},
      );

      return text;
    } catch (e) {
      throw Exception('OCR Scan Failed: $e');
    }
  }
}
