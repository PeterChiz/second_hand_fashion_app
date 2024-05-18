import 'package:get_storage/get_storage.dart';

class SHFLocalStorage {
  late final GetStorage _storage;

  // Đối tượng Singleton
  static SHFLocalStorage? _instance;

  SHFLocalStorage._internal();

  /// Tạo một constructor với tên để nhận một instance có tên bucket cụ thể
  factory SHFLocalStorage.instance() {
    _instance ??= SHFLocalStorage._internal();
    return _instance!;
  }

  /// Phương thức khởi tạo bất đồng bộ
  static Future<void> init(String bucketName) async {
    // Rất quan trọng khi bạn muốn sử dụng Bucket's
    await GetStorage.init(bucketName);
    _instance = SHFLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }

  /// Phương thức tổng quát để lưu dữ liệu
  Future<void> saveData<T>(String key, T value) async {
    await _storage.write(key, value);
  }

  /// Phương thức tổng quát để đọc dữ liệu
  T? readData<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Phương thức tổng quát để xóa dữ liệu
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

  /// Xóa tất cả dữ liệu trong bộ nhớ
  Future<void> clearAll() async {
    await _storage.erase();
  }
}
