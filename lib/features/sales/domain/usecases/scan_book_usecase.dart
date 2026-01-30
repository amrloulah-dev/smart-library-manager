import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:librarymanager/core/database/app_database.dart';
import 'package:librarymanager/core/errors/failures.dart';
import 'package:librarymanager/core/services/tesseract_ocr_service.dart';
import 'package:librarymanager/features/inventory/domain/repositories/inventory_repository.dart';
import 'package:librarymanager/features/inventory/domain/services/spine_mapping_service.dart';

@lazySingleton
class ScanBookUseCase {
  final TesseractOcrService _visionService;
  final SpineMappingService _spineMappingService;
  final InventoryRepository _inventoryRepository;

  ScanBookUseCase(
    this._visionService,
    this._spineMappingService,
    this._inventoryRepository,
  );

  Future<Either<Failure, Book>> execute(File imageFile) async {
    try {
      // 1. Analyze Image
      final text = await _visionService.extractText(imageFile.path);
      if (text.isEmpty) {
        return const Left(BookNotFoundFailure('No text detected'));
      }

      // 2. Map Text to Query
      final query = _spineMappingService.mapRawTextToQuery(text);

      // 3. Find Book
      final books = await _inventoryRepository.findBookByAttributes(query);

      if (books.isNotEmpty) {
        // Return first match
        return Right(books.first);
      } else {
        return const Left(BookNotFoundFailure());
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
