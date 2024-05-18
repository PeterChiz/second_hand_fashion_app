import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/common/widgets/texts/section_heading.dart';
import 'package:second_hand_fashion_app/data/repositories/address/address_repository.dart';
import 'package:second_hand_fashion_app/features/pertonalization/models/address_model.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/add_new_address.dart';
import 'package:second_hand_fashion_app/features/pertonalization/screens/address/widgets/single_address.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';
import 'package:second_hand_fashion_app/utils/helpers/cloud_helper_functions.dart';
import 'package:second_hand_fashion_app/utils/helpers/network_manager.dart';
import 'package:second_hand_fashion_app/utils/popups/full_screen_loader.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final city = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final addressRepository = Get.put(AddressRepository());
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;

  /// Lấy tất cả các địa chỉ của người dùng
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddresses();
      selectedAddress.value = addresses.firstWhere((element) => element.selectedAddress, orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      SHFLoaders.errorSnackBar(
          title: 'Không tìm thấy địa chỉ', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      // Xóa trường "selected"
      if(selectedAddress.value.id.isNotEmpty){
        await addressRepository.updateSelectedField(AuthenticationRepository.instance.getUserID, selectedAddress.value.id, false);
      }

      // Gán địa chỉ đã chọn
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;

      // Đặt trường "selected" thành true cho địa chỉ mới được chọn
      await addressRepository.updateSelectedField(AuthenticationRepository.instance.getUserID, selectedAddress.value.id, true);
    } catch (e) {
      SHFLoaders.errorSnackBar(
          title: 'Có lỗi khi lựa chọn', message: e.toString());
    }
  }

  ///Thêm địa chỉ mới
  Future addNewAddress() async {
    try {
      // Bắt đầu Loading
      SHFFullScreenLoader.openLoadingDialog('Đang lưu trữ địa chỉ...', SHFImages.docerAnimation);

      // Kiểm tra kết nối Internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Kiểm tra Validation của Form
      if (!addressFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      // Lưu dữ liệu Địa chỉ
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address, AuthenticationRepository.instance.getUserID);

      // Cập nhật trạng thái Địa chỉ đã chọn
      address.id = id;
      await selectAddress(address);

      // Loại bỏ Loader
      SHFFullScreenLoader.stopLoading();

      // Hiển thị Thông báo Thành công
      SHFLoaders.successSnackBar(title: 'Chúc mừng', message: 'Địa chỉ của bạn đã được lưu thành công');

      // Làm mới Dữ liệu Địa chỉ
      refreshData.toggle();

      // Đặt lại các trường
      resetFormFields();

      // Chuyển hướng
      Navigator.of(Get.context!).pop();
    } catch (e) {
      // Loại bỏ loader
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(
          title: 'Không tìm thấy địa chỉ', message: e.toString());
    }
  }

  /// Hiển thị ModalBottomSheet chọn Địa chỉ khi thanh toán
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(SHFSizes.lg),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SHFSectionHeading(
                title: 'Chọn địa chỉ'),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                /// Helper Function: Xử lý Loader, Không có Bản ghi, hoặc Thông báo LỖI
                final response = SHFCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => SHFSingAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      await selectAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: SHFSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: () => Get.to(() => const AddNewAddressScreen()), child: const Text('Thêm địa chỉ mới')),
            ),
          ],
        ),
      ),
    );
  }

  ///Hàm để đặt lại các trường form
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    city.clear();
    addressFormKey.currentState?.reset();
  }
}
