import 'package:flutter/material.dart';

/// Các hàm trợ giúp cho các hoạt động liên quan đến đám mây.
class SHFCloudHelperFunctions {

  /// Hàm trợ giúp để kiểm tra trạng thái của nhiều bản ghi (danh sách) trong cơ sở dữ liệu.
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot.
  /// Nếu dữ liệu vẫn đang tải, nó sẽ trả về một CircularProgressIndicator.
  /// Nếu không tìm thấy dữ liệu, nó sẽ trả về một thông báo "Không tìm thấy dữ liệu" hoặc một nothingFoundWidget tùy chỉnh nếu được cung cấp.
  /// Nếu xảy ra lỗi, nó sẽ trả về một thông báo lỗi chung.
  /// Nếu không có gì xảy ra, nó sẽ trả về null.
  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<List<T>> snapshot, Widget? loader, Widget? error, Widget? nothingFound}) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      if (loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if (!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty) {
      if (nothingFound != null) return nothingFound;
      return const Center(child: Text('Không có dữ liệu!'));
    }

    if (snapshot.hasError) {
      if (error != null) return error;
      return const Center(child: Text('Đã xảy ra lỗi.'));
    }

    return null;
  }
}
