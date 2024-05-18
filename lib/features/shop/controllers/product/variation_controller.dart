import 'package:get/get.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/cart_controller.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/images_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_variation_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  /// Variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation = ProductVariationModel.empty().obs;

  /// -- Kiểm tra Trạng thái Tồn kho Biến thể Sản phẩm
  void getProductVariationStockStatus() {
    variationStockStatus.value = selectedVariation.value.stock > 0 ? 'Còn hàng' : 'Hết hàng';
  }

  /// -- Thiết lập lại Các thuộc tính đã chọn khi chuyển đổi sản phẩm
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }

  /// -- Chọn Thuộc tính và Biến thể
  void onAttributeSelected(ProductModel product, attributeName, attributeValue) {
    // Khi thuộc tính được chọn, sẽ đầu tiên thêm thuộc tính đó vào selectedAttributes
    final selectedAttributes = Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] = attributeValue;

    // Chọn Biến thể Sản phẩm sử dụng tất cả các Thuộc tính đã chọn bao gồm cả thuộc tính mới được thêm vào.
    // Lặp qua tất cả các biến thể sản phẩm và tìm kiếm sự khớp với cùng các thuộc tính
    // Ví dụ: : Thuộc tính đã chọn [Màu sắc: Xanh lá, Kích thước: Nhỏ]
    // Ví dụ: : Biến thể Sản phẩm [Màu sắc: Xanh lá, Kích thước: Nhỏ] -> Sẽ được chọn.
    final ProductVariationModel selectedVariation = product.productVariations!.firstWhere(
          (variation) => _isSameAttributeValues(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    // Hiển thị ảnh Biến thể đã chọn như một ảnh chính
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value = selectedVariation.image;
    }

    // Hiển thị số lượng biến thể đã chọn đã có trong giỏ hàng.
    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController.getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    this.selectedVariation.value = selectedVariation;

    // Cập nhật trạng thái biến thể sản phẩm đã chọn
    getProductVariationStockStatus();
  }

  /// -- Kiểm tra xem các thuộc tính đã chọn có khớp với bất kỳ thuộc tính biến thể nào không
  bool _isSameAttributeValues(Map<String, dynamic> variationAttributes, Map<String, dynamic> selectedAttributes) {
    // Nếu selectedAttributes chứa 3 thuộc tính và biến thể hiện tại chứa 2 thì trả về.
    if (variationAttributes.length != selectedAttributes.length) return false;

    // Nếu bất kỳ thuộc tính nào khác nhau thì trả về. Ví dụ [Xanh lá, Lớn] x [Xanh lá, Nhỏ]
    for (final key in variationAttributes.keys) {
      // Thuộc tính[Key] = Giá trị có thể là [Xanh lá, Nhỏ, Cotton] v.v.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  /// -- Kiểm tra Sự có sẵn / Tồn kho của Thuộc tính trong Biến thể
  Set<String?> getAttributesAvailabilityInVariation(List<ProductVariationModel> variations, String attributeName) {
    // Truyền các biến thể để kiểm tra xem các thuộc tính nào có sẵn và tồn kho không
    final availableVariationAttributeValues = variations
        .where((variation) =>
    // Kiểm tra Các thuộc tính Rỗng / Hết hàng
    variation.attributeValues[attributeName] != null && variation.attributeValues[attributeName]!.isNotEmpty && variation.stock > 0)
    // Lấy tất cả các thuộc tính không rỗng của các biến thể
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }
}
