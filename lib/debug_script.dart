// ignore_for_file: avoid_print

import 'package:librarymanager/features/inventory/domain/services/spine_mapping_service.dart';

void main() {
  final service = SpineMappingService();

  void check(String input) {
    final result = service.mapRawTextToQuery(input);
  }

  check('كتاب الأضواء اللغة العربية الصف الأول الإعدادي');
  check('Gem English First Prep');
  check('Gem Second Secondary');
  check('كتاب نيوتن للصف الثالث الثانوي');
  check('الدراسات الاجتماعية 4 ابتدائي');
  check('المعاصر رياضيات 2 اعدادي الترم الاول');
  check('كتاب الامتحان دراسات أولى إعدادي');
}
