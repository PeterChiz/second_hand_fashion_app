import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';

import '../../../features/shop/models/order_model.dart';

class OrderRepository extends GetxController{
  static OrderRepository get instace => Get.find();

  ///Variable
  final _db = FirebaseFirestore.instance;

  ///Get all order related to current user
  Future<List<OrderModel>> fetchUserOrders() async{
    try{
      final userId = AuthenticationRepository.instance.authUser.uid;
      if(userId.isEmpty) throw 'Không thể tìm thấy thông tin người dùng. Hãy thử lại sau vài phút';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((documentSnapshot) => OrderModel.fromSnapshot(documentSnapshot)).toList();
    }catch(e){
      throw 'Đã xảy ra lỗi khi tìm nạp Thông tin đơn hàng. Thử lại sau.';
    }
  }

  ///Store new user order
  Future<void> saveOrder(OrderModel order, String userId) async{
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    }catch(e){
      throw 'Đã xảy ra lỗi khi lưu Thông tin đơn hàng. Thử lại sau.';
    }
  }
}