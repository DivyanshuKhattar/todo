import 'package:isar/isar.dart';

part 'local_list.g.dart';

/// "dart run build_runner build"     or use    "flutter pub run build_runner build"

@Collection()
class LocalIsarModel {
  Id id = Isar.autoIncrement;
  String? title;
  bool? isCompleted = false;
}
