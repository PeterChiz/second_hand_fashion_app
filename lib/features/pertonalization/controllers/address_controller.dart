import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:second_hand_fashion_app/common/widgets/loaders/loader.dart';
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

class AddressController extends GetxController {
  static AddressController get instance => Get.find();

  final name = TextEditingController();
  final phoneNumber = TextEditingController();
  final street = TextEditingController();
  final postalCode = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final country = TextEditingController();
  GlobalKey<FormState> addressFormKey = GlobalKey<FormState>();

  RxBool refreshData = true.obs;
  final Rx<AddressModel> selectedAddress = AddressModel.empty().obs;
  final addressRepository = Get.put(AddressRepository());

  ///Fetch all user specific addresses
  Future<List<AddressModel>> getAllUserAddresses() async {
    try {
      final addresses = await addressRepository.fetchUserAddress();
      selectedAddress.value = addresses.firstWhere(
          (element) => element.selectedAddress,
          orElse: () => AddressModel.empty());
      return addresses;
    } catch (e) {
      SHFLoaders.errorSnackBar(
          title: 'Không tìm thấy địa chỉ', message: e.toString());
      return [];
    }
  }

  Future selectAddress(AddressModel newSelectedAddress) async {
    try {
      Get.defaultDialog(
        title: '',
        onWillPop: () async {
          return false;
        },
        barrierDismissible: false,
        backgroundColor: Colors.transparent,
        // content: const SHFCircularLoader(),
      );

      //Clear the 'selected' field
      if (selectedAddress.value.id.isNotEmpty) {
        await addressRepository.updateSelectedField(
            selectedAddress.value.id, false);
      }
      //Assign selected address
      newSelectedAddress.selectedAddress = true;
      selectedAddress.value = newSelectedAddress;
      //Set the 'selected' field to true for the newly selected address
      await addressRepository.updateSelectedField(
          selectedAddress.value.id, true);

      Get.back();
    } catch (e) {
      SHFLoaders.errorSnackBar(
          title: 'Có lỗi khi lựa chọn', message: e.toString());
    }
  }

  ///Add new address
  Future addNewAddress() async {
    try {
      //start loading
      SHFFullScreenLoader.openLoadingDialog(
          'Đang tải địa chỉ', SHFImages.docerAnimation);

      //Check internet connecting
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Form validation
      if (!addressFormKey.currentState!.validate()) {
        SHFFullScreenLoader.stopLoading();
        return;
      }

      //Save address data
      final address = AddressModel(
        id: '',
        name: name.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        street: street.text.trim(),
        city: city.text.trim(),
        state: state.text.trim(),
        postalCode: postalCode.text.trim(),
        country: country.text.trim(),
        selectedAddress: true,
      );
      final id = await addressRepository.addAddress(address);

      //Update selected address status
      address.id = id;
      selectedAddress(address);

      //Remove loader
      SHFFullScreenLoader.stopLoading();

      //Show success message
      SHFLoaders.successSnackBar(
          title: 'Chúc mừng',
          message: 'Địa chỉ của bạn đã được lưu thành công');

      //Refresh address data
      refreshData.toggle();

      //Reset field
      resetFormFields();

      //Redirect
      Navigator.of(Get.context!).pop();
    } catch (e) {
      //Remove loader
      SHFFullScreenLoader.stopLoading();
      SHFLoaders.errorSnackBar(
          title: 'Không tìm thấy địa chỉ', message: e.toString());
    }
  }

  ///Show addresses ModalBottomSheet at Checkout
  Future<dynamic> selectNewAddressPopup(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => Container(
        padding: const EdgeInsets.all(SHFSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SHFSectionHeading(
                title: 'Chọn địa chỉ', showActionButton: false),
            FutureBuilder(
              future: getAllUserAddresses(),
              builder: (_, snapshot) {
                final response = SHFCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot);
                if (response != null) return response;

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => SHFSingAddress(
                    address: snapshot.data![index],
                    onTap: () async {
                      selectedAddress(snapshot.data![index]);
                      Get.back();
                    },
                  ),
                );
              },
            ),
            const SizedBox(height: SHFSizes.defaultSpace * 2),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.to(() => const AddNewAddressScreen()),
                child: const Text('Thêm địa chỉ mới'),
              ),
            )
          ],
        ),
      ),
    );
  }

  ///Function to reset form fields
  void resetFormFields() {
    name.clear();
    phoneNumber.clear();
    street.clear();
    postalCode.clear();
    city.clear();
    state.clear();
    country.clear();
    addressFormKey.currentState?.reset();
  }
}
