// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:weather_app/objectbox.g.dart';

class ClimatureDatabase {
  late final Store store;

  ClimatureDatabase._create(this.store);

  static Future<ClimatureDatabase> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: p.join(docsDir.path, "climature-database"));
    return ClimatureDatabase._create(store);
  }
}
