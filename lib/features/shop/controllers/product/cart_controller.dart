import 'package:get/get.dart';
import 'package:second_hand_fashion_app/utils/popups/loader.dart';
import 'package:second_hand_fashion_app/features/shop/controllers/product/variation_controller.dart';
import 'package:second_hand_fashion_app/features/shop/models/cart_item_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/utils/constants/enums.dart';
import 'package:second_hand_fashion_app/utils/local_storage/storage_utility.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxInt noOfCartItems = 0.obs;
  RxDouble totalCartPrice = 0.0.obs;
  RxInt productQuantityInCart = 0.obs;
  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final variationController = VariationController.instance;

  CartController() {
    loadCartItems();
  }

  /// Hàm này chuyển đổi một ProductModel thành một CartItemModel
  CartItemModel convertToCartItem(ProductModel product, int quantity) {
    if (product.productType == ProductType.single.toString()) {
      // Thiết lập lại Biến thể trong trường hợp loại sản phẩm đơn
      variationController.resetSelectedAttributes();
    }
    final variation = variationController.selectedVariation.value;
    final isVariation =
        variationController.selectedVariation.value.id.isNotEmpty;
    final price = isVariation
        ? variation.salePrice > 0.0
        ? variation.salePrice
        : variation.price
        : product.salePrice > 0.0
        ? product.salePrice
        : product.price;
    return CartItemModel(
      productId: product.id,
      title: product.title,
      price: price,
      quantity: quantity,
      variationId: variation.id,
      image: isVariation ? variation.image : product.thumbnail,
      brandName: product.brand != null ? product.brand!.name : '',
      selectedVariation: isVariation ? variation.attributeValues : null,
    );
  }

  void addToCart(ProductModel product) {
    // Kiểm tra Số lượng
    if (productQuantityInCart.value < 1) {
      SHFLoaders.customToast(message: 'Chọn số lượng');
      return;
    }

    // Biến thể đã được chọn?
    if (product.productType == ProductType.variable.toString() &&
        variationController.selectedVariation.value.id.isEmpty) {
      SHFLoaders.customToast(message: 'Chọn mặt hàng');
      return;
    }

    // Hết hàng
    if (product.productType == ProductType.variable.toString()) {
      if (variationController.selectedVariation.value.stock < 1) {
        SHFLoaders.warningSnackBar(
            message: 'Sản phẩm được chọn đã hết hàng.', title: 'Rất tiết');
        return;
      }
    } else {
      if (product.stock < 1) {
        SHFLoaders.warningSnackBar(
            message: 'Sản phẩm được chọn đã hết hàng.', title: 'Rất tiết!');
        return;
      }
    }

    // Chuyển đổi ProductModel thành CartItemModel với số lượng đã cho
    final selectedCartItem =
    convertToCartItem(product, productQuantityInCart.value);

    // Kiểm tra xem đã được thêm vào Giỏ hàng chưa
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == selectedCartItem.productId &&
        cartItem.variationId == selectedCartItem.variationId);

    if (index >= 0) {
      // Số lượng này đã được thêm hoặc Cập nhật/Xóa từ thiết kế (Giỏ hàng)(-)
      cartItems[index].quantity = selectedCartItem.quantity;
    } else {
      cartItems.add(selectedCartItem);
    }

    updateCart();
    SHFLoaders.customToast(
        message: 'Sản phẩm của bạn đã được thêm vào Giỏ hàng.');
  }

  void addOneToCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      cartItems[index].quantity += 1;
    } else {
      cartItems.add(item);
    }

    updateCart();
  }

  void removeOneFromCart(CartItemModel item) {
    int index = cartItems.indexWhere((cartItem) =>
    cartItem.productId == item.productId &&
        cartItem.variationId == item.variationId);

    if (index >= 0) {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity -= 1;
      } else {
        // Hiển thị hộp thoại trước khi loại bỏ hoàn toàn
        cartItems[index].quantity == 1
            ? removeFromCartDialog(index)
            : cartItems.removeAt(index);
      }
      updateCart();
    }
  }

  void removeFromCartDialog(int index) {
    Get.defaultDialog(
      title: 'Xóa sản phẩm',
      middleText: 'Bạn có chắc chắn muốn loại bỏ sản phẩm này?',
      onConfirm: () {
        // Loại bỏ mục khỏi giỏ hàng
        cartItems.removeAt(index);
        updateCart();
        SHFLoaders.customToast(message: 'Sản phẩm đã được xóa khỏi giỏ hàng.');
        Get.back();
      },
      onCancel: () => () => Get.back(),
    );
  }

  void updateCart() {
    updateCartTotals();
    saveCartItems();
    cartItems.refresh();
  }

  void loadCartItems() async {
    final cartItemStrings =
    SHFLocalStorage.instance().readData<List<dynamic>>('cartItems');
    if (cartItemStrings != null) {
      cartItems.assignAll(cartItemStrings
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>)));
      updateCartTotals();
    }
  }

  void updateCartTotals() {
    double calculatedTotalPrice = 0.0;
    int calculatedNoOfItems = 0;

    for (var item in cartItems) {
      calculatedTotalPrice += (item.price) * item.quantity.toDouble();
      calculatedNoOfItems += item.quantity;
    }

    totalCartPrice.value = calculatedTotalPrice;
    noOfCartItems.value = calculatedNoOfItems;
  }

  void saveCartItems() {
    final cartItemStrings = cartItems.map((item) => item.toJson()).toList();
    SHFLocalStorage.instance().saveData('cartItems', cartItemStrings);
  }

  /// -- Khởi tạo Số lượng sản phẩm đã thêm sẵn trong giỏ hàng.
  void updateAlreadyAddedProductCount(ProductModel product) {
    // Nếu sản phẩm không có biến thể thì tính toán cartEntries và hiển thị số lượng tổng.
    // Ngược lại, đặt mặc định các mục thành 0 và
    // hiển thị cartEntries khi biến thể được chọn.
    if (product.productType == ProductType.single.toString()) {
      productQuantityInCart.value = getProductQuantityInCart(product.id);
    } else {
      // Lấy Biến thể đã chọn nếu có...
      final variationId = variationController.selectedVariation.value.id;
      if (variationId.isNotEmpty) {
        productQuantityInCart.value =
            getVariationQuantityInCart(product.id, variationId);
      } else {
        productQuantityInCart.value = 0;
      }
    }
  }

  int getProductQuantityInCart(String productId) {
    final foundItem = cartItems
        .where((item) => item.productId == productId)
        .fold(0, (previousValue, element) => previousValue + element.quantity);
    return foundItem;
  }

  int getVariationQuantityInCart(String productId, String variationId) {
    final foundItem = cartItems.firstWhere(
          (item) => item.productId == productId && item.variationId == variationId,
      orElse: () => CartItemModel.empty(),
    );

    return foundItem.quantity;
  }

  void clearCart() {
    productQuantityInCart.value = 0;
    cartItems.clear();
    updateCart();
  }
}
