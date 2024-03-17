import 'package:get_storage/get_storage.dart';

class SHFLocalStorage{
  static final SHFLocalStorage _instance = SHFLocalStorage._internal();

  factory SHFLocalStorage(){
    return _instance;
  }

  SHFLocalStorage._internal();

  final _storage = GetStorage();

  Future<void> saveData<SHF>(String key, SHF value) async{
    await _storage.write(key, value);
  }

  SHF? readData<SHF>(String key) {
    return _storage.read<SHF>(key);
  }

  Future<void> removeData(String key) async{
    await _storage.remove(key);
  }

  Future<void> clearAll() async{
    await _storage.erase();
  }
}
