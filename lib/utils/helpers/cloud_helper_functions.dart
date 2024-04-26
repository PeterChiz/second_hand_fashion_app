import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

///Helper functions for cloud-related operations
class SHFCloudHelperFunctions{
  ///Hàm trợ giúp để kiểm tra trạng thái của một bản ghi cơ sở dữ liệu
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot
  /// Nếu dữ liệu vẫn đang tải, nó sẽ trả về CircularProgressIndicator
  /// Nếu không tìm thấy dữ liệu, nó trả về thông báo chung 'Không tìm thấy dữ liệu'
  /// Nếu xảy ra lỗi, nó sẽ trả về một thông báo lỗi chung
  /// Ngược lại trả về null

  static Widget? checkSingleRecordState<T>(AsyncSnapshot<T> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(child: CircularProgressIndicator(),);
    }

    if(!snapshot.hasData || snapshot.data == null){
      return const Center(child: Text('Không tìm thấy dữ liệu'),);
    }

    if(snapshot.hasError){
      return const Center(child: Text('Có lỗi gì đó đã xảy ra'),);
    }

    return null;
  }
  ///Hàm trợ giúp để kiểm tra trạng thái của nhiều bản ghi database (danh sách)
  ///
  /// Trả về một Widget dựa trên trạng thái của snapshot
  /// Nếu dữ liệu vẫn đang tải, nó sẽ trả CircularProgressIndicator
  /// Nếu không tìm thấy dữ liệu, nó sẽ trả về thông báo chung 'Không tìm thấy dữ liệu' hoặc một NothingFoundWidget tùy chỉnh nếu được cung cấp
  /// Nếu xảy ra lỗi, nó sẽ trả về một thông báo lỗi chung
  /// Ngược lại trả về null

  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<List<T>> snapshot, Widget? loader, Widget? error, Widget? nothingFound}){
    if(snapshot.connectionState == ConnectionState.waiting){
      if(loader != null) return loader;
      return const Center(child: CircularProgressIndicator(),);
    }

    if(!snapshot.hasData || snapshot.data == null || snapshot.data!.isEmpty){
      if(nothingFound != null) return nothingFound;
      return const Center(child: Text('Không tìm thấy data'),);
    }

    if(snapshot.hasError){
      if(error != null) return error;
      return const Center(child: Text('Có lỗi gì đó đã xảy ra'),);
    }

    return null;
  }

  ///Tạo một tham chiếu với đường dẫn và tên tệp ban đầu và truy xuất download URL
  static Future<String> getURLFromFilePathAndName(String path) async{
    try{
      if(path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseException catch(e){
      throw e.message!;
    } on PlatformException catch(e){
      throw e.message!;
    } catch(e){
      throw 'Có lỗi gì đó xảy ra';
    }
  }
}