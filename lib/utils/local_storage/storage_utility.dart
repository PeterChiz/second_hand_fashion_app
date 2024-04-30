import 'package:get_storage/get_storage.dart';

class SHFLocalStorage{

  late final GetStorage _storage;

  //
  static SHFLocalStorage? _instance;

  SHFLocalStorage._internal();

  factory SHFLocalStorage.instance(){
    _instance ??= SHFLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = SHFLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  //phuong phap chung de luu du lieu
  Future<void> saveData<SHF>(String key, SHF value) async{
    await _storage.write(key, value);
  }

  //Generic method to read data
  SHF? readData<SHF>(String key) {
    return _storage.read<SHF>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) async{
    await _storage.remove(key);
  }

  Future<void> clearAll() async{
    await _storage.erase();
  }
}
