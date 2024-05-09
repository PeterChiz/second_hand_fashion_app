import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instance => Get.find();

  ///Variable
  final _db = FirebaseFirestore.instance;

  ///Nhận tất cả các đơn hàng liên quan đến người dùng hiện tại
  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userId = AuthenticationRepository.instance.getUserID;
      if(userId.isEmpty) throw 'Không thể tìm thấy thông tin người dùng. Hãy thử lại sau vài phút';

      // Sub Collection Order -> Replaced with main Collection
      // final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      final result = await _db.collection('Orders').where('userId', isEqualTo: userId).get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    }catch(e){
      throw 'Đã xảy ra lỗi khi tìm nạp Thông tin đơn hàng. Thử lại sau.';
    }
  }

  ///Lưu trữ đơn đặt hàng của người dùng mới
  Future<void> saveOrder(OrderModel order, String userId) async{
    try{
      await _db.collection('Orders').add(order.toJson());
    }catch(e){
      throw 'Đã xảy ra lỗi khi lưu Thông tin đơn hàng. Thử lại sau.';
    }
  }
}