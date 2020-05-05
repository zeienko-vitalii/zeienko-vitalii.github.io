import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DbManager {
  factory DbManager() => _instance;

  DbManager._internal();

  static final DbManager _instance = DbManager._internal();

  Future<void> init() async {
    await Hive.initFlutter();
  }

  Future<Box<T>> getBox<T>(String boxName) =>
      Hive.isBoxOpen(boxName) ? Future<Box<T>>.value(Hive.box(boxName)) : Hive.openBox<T>(boxName);

  Future<void> dispose() {
    return Hive.close();
  }
}
