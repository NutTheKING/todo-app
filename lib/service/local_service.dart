import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/domain/enums/local_services.dart';

class LocalService {
  LocalService._internal();

  static final LocalService _instance = LocalService._internal();

  factory LocalService() {
    return _instance;
  }

  bool initialized = false;

  late Box _localObjectBox;

  Future<void> getInstance() async {
    if (initialized) return;

    final directory = await getApplicationDocumentsDirectory();

    if (Platform.isMacOS) {
      Hive.init(directory.path);
      _localObjectBox = await Hive.openBox('APP_DATA');
    } else {
      const storage = FlutterSecureStorage();
      String? encryptKey = await storage.read(key: "key");

      if (encryptKey == null) {
        var key1 = Hive.generateSecureKey();
        await storage.write(key: "key", value: base64.encode(key1));
        encryptKey = await storage.read(key: "key");
      }

      List<int> key = base64.decode(encryptKey!);

      Hive.init(directory.path);
      _localObjectBox = await Hive.openBox('APP_DATA', encryptionCipher: HiveAesCipher(key));
    }
    initialized = true;
  }

  Future<void> saveValue(LocalDataFieldName localDataFieldName, dynamic value) async {
    await _localObjectBox.put(localDataFieldName.toString(), value);
  }

  Future<dynamic> getSavedValue(LocalDataFieldName localDataFieldName) async {
    return _localObjectBox.get(localDataFieldName.toString());
  }

  Future<void> deleteSavedValue(LocalDataFieldName localDataFieldName) async {
    await _localObjectBox.delete(localDataFieldName.toString());
  }

  Future<void> deleteAllSavedValue() async {
    await _localObjectBox.clear();
  }

  Future<void> saveValueData(String name, dynamic value) async {
    await _localObjectBox.put(name, value);
  }

  Future<dynamic> getSavedValueData(String name) async {
    return _localObjectBox.get(name);
  }
}
