import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/data/repositories/authentication/authentication_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/address_model.dart';

class AddressRepository extends GetxController{
  static AddressRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;

  /// Get all order related to current User
  Future<List<AddressModel>> fetchUserAddresses() async{
    try{
      final userId = AuthenticationRepository.instance.firebaseUser!.uid;
      if (userId.isEmpty) throw 'Không tìm thấy thông tin người dùng. Hãy thử lại sau vài phút.';

      final result = await _db.collection('Users').doc(userId).collection('Addresses').get();
      return result.docs.map((documentSnapshot) => AddressModel.fromDocumentSnapshot(documentSnapshot)).toList();
    }catch(e){
      throw 'Đã xảy ra lỗi khi tìm thông tin địa chỉ. Thử lại sau';
    }
  }

  /// Store new user order
  Future<String> addAddress(AddressModel address, String userId) async{
    try{
      final currentAddress = await _db.collection('Users').doc(userId).collection('Addresses').add(address.toJson());
      return currentAddress.id;
    }catch(e){
      throw 'Đã xảy ra lỗi khi lưu thông tin địa chỉ khách hàng, vui lòng thử lại sau';
    }
  }

  ///Clear the 'Selected' field for all the addresses
  Future<void> updateSelectedField (String userId, String addressId, bool selected) async{
    try{
      await _db.collection('Users').doc(userId).collection('Addresses').doc(addressId).update({'SelectedAddress': selected});
    }catch(e){
      throw 'Không thể cập nhật lựa chọn địa chỉ của bạn. Vui lòng thử lại sau';
    }
  }


}