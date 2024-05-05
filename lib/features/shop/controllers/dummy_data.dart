import '../../../routes/routes.dart';
import '../../../utils/constants/enums.dart';
import '../../../utils/constants/image_strings.dart';

import '../../pertonalization/models/address_model.dart';
import '../../pertonalization/models/user_model.dart';
import '../models/banner_model.dart';
import '../models/brand_category_model.dart';
import '../models/brand_model.dart';
import '../models/cart_item_model.dart';
import '../models/cart_model.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../models/product_attribute_model.dart';
import '../models/product_category_model.dart';
import '../models/product_model.dart';
import '../models/product_review_model.dart';
import '../models/product_variation_model.dart';

class SHFDummyData {
  /// -- Banners
  static final List<BannerModel> banners = [
    BannerModel(imageUrl: SHFImages.banner1, targetScreen: SHFRoutes.order, active: false),
    BannerModel(imageUrl: SHFImages.banner2, targetScreen: SHFRoutes.cart, active: true),
    BannerModel(imageUrl: SHFImages.banner3, targetScreen: SHFRoutes.favourites, active: true),
    BannerModel(imageUrl: SHFImages.banner4, targetScreen: SHFRoutes.search, active: true),
    BannerModel(imageUrl: SHFImages.banner5, targetScreen: SHFRoutes.settings, active: true),
    BannerModel(imageUrl: SHFImages.banner6, targetScreen: SHFRoutes.userAddress, active: true),
    BannerModel(imageUrl: SHFImages.banner8, targetScreen: SHFRoutes.checkout, active: false),
  ];

  /// -- User
  static final UserModel user = UserModel(
    firstName: 'Chi',
    lastName: 'Bui',
    email: 'chibui@gmail.com',
    phoneNumber: '0773872129',
    profilePicture: SHFImages.user,
    addresses: [
      AddressModel(
        id: '1',
        name: 'Bui Thien Chi',
        phoneNumber: '0773872129',
        street: 'Phuoc Dong',
        city: 'Nha Trang',
        state: 'Khanh Hoa',
        postalCode: '87665',
        country: 'Viet Nam',
      ),

      AddressModel(
        id: '2',
        name: 'Bui Thien Chi',
        phoneNumber: '0773872125',
        street: 'Phuoc Ha',
        city: 'Nha Trang',
        state: 'Khanh Hoa',
        postalCode: '90001',
        country: 'Viet Nam',
      ),

    ],
    username: '',
    id: '',
  );

  /// -- Cart
  static final CartModel cart = CartModel(
    cartId: '001',
    items: [
      CartItemModel(
        productId: '001',
        variationId: '1',
        quantity: 1,
        title: products[0].title,
        image: products[0].thumbnail,
        brandName: products[0].brand!.name,
        price: products[0].productVariations![0].price,
        selectedVariation: products[0].productVariations![0].attributeValues,
      ),
      CartItemModel(
        productId: '002',
        variationId: '',
        quantity: 1,
        title: products[1].title,
        image: products[1].thumbnail,
        brandName: products[1].brand!.name,
        price: products[1].price,
        selectedVariation: products[1].productVariations != null ? products[1].productVariations![1].attributeValues : {},
      ),
    ],
  );

  /// -- Order
  static final List<OrderModel> orders = [
    OrderModel(
        id: 'SHF0012',
        status: OrderStatus.processing,
        items: cart.items,
        totalAmount: 265,
        orderDate: DateTime(2023, 09, 1),
        deliveryDate: DateTime(2023, 09, 9)),
    OrderModel(
        id: 'SHF0025',
        status: OrderStatus.shipped,
        items: cart.items,
        totalAmount: 369,
        orderDate: DateTime(2023, 10, 2),
        deliveryDate: DateTime(2023, 10, 6)),
    OrderModel(
        id: 'SHF0152',
        status: OrderStatus.delivered,
        items: cart.items,
        totalAmount: 254,
        orderDate: DateTime(2023, 11, 3),
        deliveryDate: DateTime(2023, 11, 8)),
    OrderModel(
        id: 'SHF0265',
        status: OrderStatus.delivered,
        items: cart.items,
        totalAmount: 355,
        orderDate: DateTime(2023, 12, 20),
        deliveryDate: DateTime(2023, 12, 25)),
    OrderModel(
        id: 'SHF1536',
        status: OrderStatus.delivered,
        items: cart.items,
        totalAmount: 115,
        orderDate: DateTime(2023, 12, 25),
        deliveryDate: DateTime(2024, 01, 1)),
  ];

  /// -- List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(id: '1', image: SHFImages.sportIcon, name: 'Áo', isFeatured: true),
    CategoryModel(id: '2', image: SHFImages.furnitureIcon, name: 'Quần', isFeatured: true),
    CategoryModel(id: '3', image: SHFImages.electronicsIcon, name: 'Giày', isFeatured: true),
    CategoryModel(id: '4', image: SHFImages.clothIcon, name: 'Mũ', isFeatured: true),
    CategoryModel(id: '5', image: SHFImages.animalIcon, name: 'Kính', isFeatured: true),
    CategoryModel(id: '6', image: SHFImages.shoeIcon, name: 'Đầm', isFeatured: false),
    CategoryModel(id: '7', image: SHFImages.cosmeticsIcon, name: 'Túi', isFeatured: false),

    ///subcategories
    CategoryModel(id: '8', image: SHFImages.sportIcon, name: 'Áo thể thao', parentId: '1', isFeatured: true),
    CategoryModel(id: '9', image: SHFImages.sportIcon, name: 'Áo da', parentId: '1', isFeatured: true),
    CategoryModel(id: '10', image: SHFImages.sportIcon, name: 'Áo sơ mi', parentId: '1', isFeatured: true),
    CategoryModel(id: '11', image: SHFImages.sportIcon, name: 'Áo khoác', parentId: '1', isFeatured: true),
    CategoryModel(id: '12', image: SHFImages.sportIcon, name: 'Áo thun', parentId: '1', isFeatured: true),
    //furniture
    CategoryModel(id: '13', image: SHFImages.furnitureIcon, name: 'Quần jean', parentId: '2', isFeatured: true),
    CategoryModel(id: '14', image: SHFImages.furnitureIcon, name: 'Quần kaki', parentId: '2', isFeatured: true),
    CategoryModel(id: '15', image: SHFImages.furnitureIcon, name: 'Quần thể thao', parentId: '2', isFeatured: true),
    CategoryModel(id: '16', image: SHFImages.furnitureIcon, name: 'Quần sọt', parentId: '2', isFeatured: true),
    CategoryModel(id: '17', image: SHFImages.furnitureIcon, name: 'Quần thun', parentId: '2', isFeatured: true),
    //electronics
    CategoryModel(id: '18', image: SHFImages.electronicsIcon, name: 'Giày lười', parentId: '3', isFeatured: true),
    CategoryModel(id: '19', image: SHFImages.electronicsIcon, name: 'Giày tây', parentId: '3', isFeatured: true),
    CategoryModel(id: '20', image: SHFImages.electronicsIcon, name: 'Giày thể thao', parentId: '3', isFeatured: true),

    CategoryModel(id: '21', image: SHFImages.clothIcon, name: 'Mũ bucket', parentId: '4', isFeatured: true),
    CategoryModel(id: '22', image: SHFImages.clothIcon, name: 'Mũ lưỡi trai', parentId: '4', isFeatured: true),

    CategoryModel(id: '23', image: SHFImages.clothIcon, name: 'Kính mát', parentId: '5', isFeatured: true),
    CategoryModel(id: '24', image: SHFImages.clothIcon, name: 'Kính râm', parentId: '5', isFeatured: true),

    CategoryModel(id: '25', image: SHFImages.clothIcon, name: 'Đầm ngắn', parentId: '6', isFeatured: false),
    CategoryModel(id: '26', image: SHFImages.clothIcon, name: 'Đầm dài', parentId: '6', isFeatured: false),

    CategoryModel(id: '27', image: SHFImages.clothIcon, name: 'Túi xách', parentId: '7', isFeatured: false),
    CategoryModel(id: '28', image: SHFImages.clothIcon, name: 'Túi đeo chéo', parentId: '7', isFeatured: false),
  ];

  /// -- List of all Brands
  static final List<BrandModel> brands = [
    BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas', productsCount: 95, isFeatured: true),
    BrandModel(id: '2', image: SHFImages.hermanMillerLogo, name: 'Herman Miller', productsCount: 95, isFeatured: true),
    BrandModel(id: '3', image: SHFImages.jordanLogo, name: 'Jordan', productsCount: 36, isFeatured: true),
    BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike', productsCount: 265, isFeatured: true),
    BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma', productsCount: 65, isFeatured: true),
    BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'ZARA', productsCount: 36, isFeatured: true),
  ];

  /// -- List of all Brand Categories 1.áo 2.quần 3.giày 4. mũ 5.kính
  static final List<BrandCategoryModel> brandCategory = [
    BrandCategoryModel(brandId: '1', categoryId: '8'),
    BrandCategoryModel(brandId: '1', categoryId: '9'),
    BrandCategoryModel(brandId: '1', categoryId: '10'),
    BrandCategoryModel(brandId: '1', categoryId: '11'),
    BrandCategoryModel(brandId: '1', categoryId: '12'),
    BrandCategoryModel(brandId: '1', categoryId: '13'),
    BrandCategoryModel(brandId: '1', categoryId: '14'),
    BrandCategoryModel(brandId: '1', categoryId: '15'),
    BrandCategoryModel(brandId: '1', categoryId: '16'),
    BrandCategoryModel(brandId: '1', categoryId: '17'),
    BrandCategoryModel(brandId: '1', categoryId: '18'),
    BrandCategoryModel(brandId: '1', categoryId: '19'),
    BrandCategoryModel(brandId: '1', categoryId: '20'),
    BrandCategoryModel(brandId: '1', categoryId: '21'),
    BrandCategoryModel(brandId: '1', categoryId: '22'),
    BrandCategoryModel(brandId: '1', categoryId: '23'),
    BrandCategoryModel(brandId: '1', categoryId: '24'),

    BrandCategoryModel(brandId: '2', categoryId: '23'),
    BrandCategoryModel(brandId: '2', categoryId: '24'),
    BrandCategoryModel(brandId: '2', categoryId: '13'),
    BrandCategoryModel(brandId: '2', categoryId: '14'),

    BrandCategoryModel(brandId: '3', categoryId: '20'),
    BrandCategoryModel(brandId: '3', categoryId: '19'),
    BrandCategoryModel(brandId: '3', categoryId: '18'),

    BrandCategoryModel(brandId: '4', categoryId: '18'),
    BrandCategoryModel(brandId: '4', categoryId: '19'),
    BrandCategoryModel(brandId: '4', categoryId: '20'),

    BrandCategoryModel(brandId: '5', categoryId: '13'),
    BrandCategoryModel(brandId: '5', categoryId: '14'),
    BrandCategoryModel(brandId: '5', categoryId: '15'),
    BrandCategoryModel(brandId: '5', categoryId: '16'),
    BrandCategoryModel(brandId: '5', categoryId: '17'),

    BrandCategoryModel(brandId: '6', categoryId: '18'),
    BrandCategoryModel(brandId: '6', categoryId: '19'),
    BrandCategoryModel(brandId: '6', categoryId: '20'),

  ];

  /// -- List of all Product Categories
  static final List<ProductCategoryModel> productCategories = [
    ProductCategoryModel(productId: '001', categoryId: '3'),
    ProductCategoryModel(productId: '001', categoryId: '20'),
    ProductCategoryModel(productId: '004', categoryId: '1'),
    ProductCategoryModel(productId: '002', categoryId: '12'),
    ProductCategoryModel(productId: '002', categoryId: '1'),
    ProductCategoryModel(productId: '003', categoryId: '1'),
    ProductCategoryModel(productId: '003', categoryId: '11'),
    ProductCategoryModel(productId: '005', categoryId: '20'),
    ProductCategoryModel(productId: '005', categoryId: '3'),
    ProductCategoryModel(productId: '006', categoryId: '17'),
    ProductCategoryModel(productId: '006', categoryId: '2'),
    ProductCategoryModel(productId: '007', categoryId: '15'),
    ProductCategoryModel(productId: '007', categoryId: '2'),
    ProductCategoryModel(productId: '009', categoryId: '3'),
    ProductCategoryModel(productId: '009', categoryId: '18'),
    ProductCategoryModel(productId: '010', categoryId: '1'),
    ProductCategoryModel(productId: '010', categoryId: '18'),
    ProductCategoryModel(productId: '010', categoryId: '3'),
    ProductCategoryModel(productId: '011', categoryId: '3'),
    ProductCategoryModel(productId: '011', categoryId: '8'),
    ProductCategoryModel(productId: '012', categoryId: '1'),
    ProductCategoryModel(productId: '012', categoryId: '8'),
    ProductCategoryModel(productId: '013', categoryId: '1'),
    ProductCategoryModel(productId: '013', categoryId: '8'),

    ProductCategoryModel(productId: '014', categoryId: '1'),
    ProductCategoryModel(productId: '014', categoryId: '9'),
    ProductCategoryModel(productId: '015', categoryId: '1'),
    ProductCategoryModel(productId: '015', categoryId: '9'),
    ProductCategoryModel(productId: '016', categoryId: '1'),
    ProductCategoryModel(productId: '016', categoryId: '9'),
    ProductCategoryModel(productId: '017', categoryId: '1'),
    ProductCategoryModel(productId: '017', categoryId: '9'),

    ProductCategoryModel(productId: '018', categoryId: '1'),
    ProductCategoryModel(productId: '018', categoryId: '10'),
    ProductCategoryModel(productId: '019', categoryId: '1'),
    ProductCategoryModel(productId: '019', categoryId: '10'),
    ProductCategoryModel(productId: '020', categoryId: '1'),
    ProductCategoryModel(productId: '020', categoryId: '10'),
    ProductCategoryModel(productId: '021', categoryId: '1'),
    ProductCategoryModel(productId: '021', categoryId: '10'),

    ProductCategoryModel(productId: '022', categoryId: '5'),
    ProductCategoryModel(productId: '022', categoryId: '11'),
    ProductCategoryModel(productId: '023', categoryId: '5'),
    ProductCategoryModel(productId: '023', categoryId: '11'),
    ProductCategoryModel(productId: '024', categoryId: '5'),
    ProductCategoryModel(productId: '024', categoryId: '11'),
    ProductCategoryModel(productId: '025', categoryId: '5'),
    ProductCategoryModel(productId: '025', categoryId: '11'),

    ProductCategoryModel(productId: '026', categoryId: '5'),
    ProductCategoryModel(productId: '026', categoryId: '12'),
    ProductCategoryModel(productId: '027', categoryId: '5'),
    ProductCategoryModel(productId: '027', categoryId: '12'),
    ProductCategoryModel(productId: '028', categoryId: '5'),
    ProductCategoryModel(productId: '028', categoryId: '12'),

    ProductCategoryModel(productId: '029', categoryId: '5'),
    ProductCategoryModel(productId: '029', categoryId: '13'),
    ProductCategoryModel(productId: '030', categoryId: '5'),
    ProductCategoryModel(productId: '030', categoryId: '13'),
    ProductCategoryModel(productId: '031', categoryId: '5'),
    ProductCategoryModel(productId: '031', categoryId: '13'),
    ProductCategoryModel(productId: '032', categoryId: '5'),
    ProductCategoryModel(productId: '032', categoryId: '13'),

    ProductCategoryModel(productId: '033', categoryId: '2'),
    ProductCategoryModel(productId: '033', categoryId: '14'),
    ProductCategoryModel(productId: '034', categoryId: '2'),
    ProductCategoryModel(productId: '034', categoryId: '14'),
    ProductCategoryModel(productId: '035', categoryId: '2'),
    ProductCategoryModel(productId: '035', categoryId: '14'),
    ProductCategoryModel(productId: '036', categoryId: '2'),
    ProductCategoryModel(productId: '036', categoryId: '14'),

    ProductCategoryModel(productId: '037', categoryId: '2'),
    ProductCategoryModel(productId: '037', categoryId: '15'),
    ProductCategoryModel(productId: '038', categoryId: '2'),
    ProductCategoryModel(productId: '038', categoryId: '15'),


  ];

  /// -- List of all Products
  static final List<ProductModel> products = [
    ProductModel(
      id: '001',
      title: 'Green Nike sports shoe',
      stock: 15,
      price: 135000,
      isFeatured: true,
      thumbnail: SHFImages.productImage1,
      description: 'Green Nike sports shoe',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike', productsCount: 265, isFeatured: true),
      images: [SHFImages.productImage1, SHFImages.productImage23, SHFImages.productImage21, SHFImages.productImage9],
      salePrice: 30000,
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Green', 'Black', 'Red']),
        ProductAttributeModel(name: 'Size', values: ['X', 'M', 'L']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134000,
            salePrice: 12206,
            image: SHFImages.productImage1,
            description: 'This is a Product description for Green Nike sports shoe.',
            attributeValues: {'Color': 'Green', 'Size': 'L'}),
        ProductVariationModel(
            id: '2', stock: 15, price: 132000, image: SHFImages.productImage23, attributeValues: {'Color': 'Black', 'Size': 'M'}),
        ProductVariationModel(
            id: '3', stock: 0, price: 234000, image: SHFImages.productImage23, attributeValues: {'Color': 'Black', 'Size': 'L'}),
        ProductVariationModel(
            id: '4', stock: 222, price: 232000, image: SHFImages.productImage1, attributeValues: {'Color': 'Green', 'Size': 'M'}),
        ProductVariationModel(
            id: '5', stock: 0, price: 334000, image: SHFImages.productImage21, attributeValues: {'Color': 'Red', 'Size': 'L'}),
        ProductVariationModel(
            id: '6', stock: 11, price: 332000, image: SHFImages.productImage21, attributeValues: {'Color': 'Red', 'Size': 'M'}),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '002',
      title: 'Blue T-shirt for all ages',
      stock: 15,
      price: 350000,
      isFeatured: true,
      thumbnail: SHFImages.productImage69,
      description:
      'This is a Product description for Blue Nike Sleeve less vest. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'ZARA'),
      images: [SHFImages.productImage68, SHFImages.productImage69, SHFImages.productImage5],
      salePrice: 30000,
      sku: 'ABR4568',
      categoryId: '12',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '003',
      title: 'Leather brown Jacket',
      stock: 15,
      price: 380000,
      isFeatured: false,
      thumbnail: SHFImages.productImage64,
      description:
      'This is a Product description for Leather brown Jacket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'ZARA'),
      images: [SHFImages.productImage64, SHFImages.productImage65, SHFImages.productImage66, SHFImages.productImage67],
      salePrice: 30000,
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '004',
      title: '4 Color collar t-shirt dry fit',
      stock: 15,
      price: 1350000,
      isFeatured: false,
      thumbnail: SHFImages.productImage60,
      description:
      'This is a Product description for 4 Color collar t-shirt dry fit. There are more things that can be added but its just a demo and nothing else.',
      brand: BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'ZARA'),
      images: [SHFImages.productImage60, SHFImages.productImage61, SHFImages.productImage62, SHFImages.productImage63],
      salePrice: 300000,
      sku: 'ABR4568',
      categoryId: '12',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Red', 'Yellow', 'Green', 'Blue']),
        ProductAttributeModel(name: 'Size', values: ['X', 'M', 'L']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 34,
            price: 134000,
            salePrice: 12260,
            image: SHFImages.productImage60,
            description: 'This is a Product description for 4 Color collar t-shirt dry fit',
            attributeValues: {'Color': 'Red', 'Size': 'L'}),
        ProductVariationModel(
            id: '2', stock: 15, price: 132000, image: SHFImages.productImage60, attributeValues: {'Color': 'Red', 'Size': 'M'}),
        ProductVariationModel(
            id: '3', stock: 0, price: 2340000, image: SHFImages.productImage61, attributeValues: {'Color': 'Yellow', 'Size': 'L'}),
        ProductVariationModel(
            id: '4', stock: 222, price: 232000, image: SHFImages.productImage61, attributeValues: {'Color': 'Yellow', 'Size': 'M'}),
        ProductVariationModel(
            id: '5', stock: 0, price: 334000, image: SHFImages.productImage62, attributeValues: {'Color': 'Green', 'Size': 'L'}),
        ProductVariationModel(
            id: '6', stock: 11, price: 332000, image: SHFImages.productImage62, attributeValues: {'Color': 'Green', 'Size': 'X'}),
        ProductVariationModel(
            id: '7', stock: 0, price: 334000, image: SHFImages.productImage63, attributeValues: {'Color': 'Blue', 'Size': 'X'}),
        ProductVariationModel(
            id: '8', stock: 11, price: 332000, image: SHFImages.productImage63, attributeValues: {'Color': 'Blue', 'Size': 'L'}),
      ],
      productType: ProductType.variable.toString(),
    ),

    ///Products after banner
    ProductModel(
      id: '005',
      title: 'Nike Air Jordon Shoes',
      stock: 15,
      price: 350000,
      isFeatured: false,
      thumbnail: SHFImages.productImage10,
      description: 'Nike Air Jordon Shoes for running. Quality product, Long Lasting',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike', productsCount: 265, isFeatured: true),
      images: [SHFImages.productImage7, SHFImages.productImage8, SHFImages.productImage9, SHFImages.productImage10],
      salePrice: 30000,
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Orange', 'Black', 'Brown']),
        ProductAttributeModel(name: 'Size', values: ['X', 'M', 'L']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 16,
            price: 3600000,
            salePrice: 126000,
            image: SHFImages.productImage8,
            description:
            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
            attributeValues: {'Color': 'Orange', 'Size': 'L'}),
        ProductVariationModel(
            id: '2', stock: 15, price: 35000, image: SHFImages.productImage7, attributeValues: {'Color': 'Black', 'Size': 'M'}),
        ProductVariationModel(
            id: '3', stock: 14, price: 340000, image: SHFImages.productImage9, attributeValues: {'Color': 'Brown', 'Size': 'L'}),
        ProductVariationModel(
            id: '4', stock: 13, price: 33000, image: SHFImages.productImage7, attributeValues: {'Color': 'Black', 'Size': 'L'}),
        ProductVariationModel(
            id: '5', stock: 12, price: 32000, image: SHFImages.productImage9, attributeValues: {'Color': 'Brown', 'Size': 'M'}),
        ProductVariationModel(
            id: '6', stock: 11, price: 31000, image: SHFImages.productImage8, attributeValues: {'Color': 'Orange', 'Size': 'M'}),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '006',
      title: 'Quần thun Adidas',
      stock: 15,
      price: 750000,
      isFeatured: false,
      thumbnail: SHFImages.productImage11,
      description: 'SAMSUNG Galaxy S9 (Pink, 64 GB)  (4 GB RAM), Long Battery timing',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      images: [SHFImages.productImage11, SHFImages.productImage12, SHFImages.productImage13, SHFImages.productImage12],
      salePrice: 650000,
      sku: 'ABR4568',
      categoryId: '17',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '007',
      title: 'Quần thể thao Adidas',
      stock: 15,
      price: 200000,
      isFeatured: false,
      thumbnail: SHFImages.productImage18,
      description:
      'This is a Product description for TOMI Dog food. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      salePrice: 10000,
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //008 after 040
    ProductModel(
      id: '009',
      title: 'Nike Air Jordon 19 Blue',
      stock: 15,
      price: 400000,
      isFeatured: false,
      thumbnail: SHFImages.productImage19,
      description:
      'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage19, SHFImages.productImage20, SHFImages.productImage21, SHFImages.productImage22],
      salePrice: 200000,
      sku: 'ABR4568',
      categoryId: '18',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '010',
      title: 'Nike Air Jordon 6 Orange',
      stock: 15,
      price: 400000,
      thumbnail: SHFImages.productImage20,
      description:
      'This is a Product description for Nike Air Jordon. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage20, SHFImages.productImage23, SHFImages.productImage21, SHFImages.productImage22],
      // salePrice: 200,
      sku: 'ABR4568',
      categoryId: '18',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '011',
      title: 'Nike Air Max Red & Black',
      stock: 15,
      price: 6000000,
      isFeatured: true,
      thumbnail: SHFImages.productImage21,
      description:
      'This is a Product description for Nike Air Max. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage21, SHFImages.productImage20, SHFImages.productImage19, SHFImages.productImage22],
      salePrice: 400000,
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '012',
      title: 'Nike Basketball shoes Black & Green',
      stock: 15,
      price: 600000,
      isFeatured: false,
      thumbnail: SHFImages.productImage22,
      description:
      'This is a Product description for Nike Basketball shoes. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage22, SHFImages.productImage20, SHFImages.productImage21, SHFImages.productImage23],
      salePrice: 400000,
      sku: 'ABR4568',
      categoryId: '19',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '013',
      title: 'Nike wild horse shoes',
      stock: 15,
      price: 600000,
      isFeatured: false,
      thumbnail: SHFImages.productImage23,
      description:
      'This is a Product description for Nike wild horse shoes. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage23, SHFImages.productImage20, SHFImages.productImage21, SHFImages.productImage22],
      salePrice: 400000,
      sku: 'ABR4568',
      categoryId: '19',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Track suits
    ProductModel(
      id: '014',
      title: 'Nike Track suit red',
      stock: 150,
      price: 500000,
      isFeatured: true,
      thumbnail: SHFImages.productImage26,
      description:
      'This is a Product description for Nike Track suit red. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage26, SHFImages.productImage24, SHFImages.productImage25, SHFImages.productImage27],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '015',
      title: 'Nike Track suit Black',
      stock: 15,
      price: 200000,
      thumbnail: SHFImages.productImage24,
      description:
      'This is a Product description for Nike Track suit Black. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage24, SHFImages.productImage26, SHFImages.productImage25, SHFImages.productImage27],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '19',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '016',
      title: 'Nike Track suit Blue',
      stock: 15,
      price: 100000,
      thumbnail: SHFImages.productImage25,
      description:
      'This is a Product description for Nike Track suit Blue. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage25, SHFImages.productImage24, SHFImages.productImage26, SHFImages.productImage27],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '19',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '017',
      title: 'Nike Track suit Parrot Green',
      stock: 15,
      price: 350000,
      thumbnail: SHFImages.productImage27,
      description:
      'This is a Product description for Nike Track suit Parrot Green. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '4', image: SHFImages.nikeLogo, name: 'Nike'),
      images: [SHFImages.productImage27, SHFImages.productImage24, SHFImages.productImage25, SHFImages.productImage26],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '19',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Sports Equipments
    ProductModel(
      id: '018',
      title: 'Adidas Football',
      stock: 15,
      price: 40000,
      isFeatured: true,
      thumbnail: SHFImages.productImage28,
      description:
      'This is a Product description for Football. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      images: [SHFImages.productImage28, SHFImages.productImage29, SHFImages.productImage30, SHFImages.productImage31],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '019',
      title: 'Baseball Bat',
      stock: 15,
      price: 30000,
      thumbnail: SHFImages.productImage29,
      description:
      'This is a Product description for Baseball Bat. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      images: [SHFImages.productImage29, SHFImages.productImage28, SHFImages.productImage30, SHFImages.productImage31],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '22',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '020',
      title: 'Cricket Bat',
      stock: 15,
      price: 250000,
      thumbnail: SHFImages.productImage30,
      description:
      'This is a Product description for Cricket Bat. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      images: [SHFImages.productImage30, SHFImages.productImage29, SHFImages.productImage28, SHFImages.productImage31],
      // saleprice: 400000,
      sku: 'ABR4568',
      categoryId: '21',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '021',
      title: 'Tennis Racket',
      stock: 15,
      price: 540000,
      thumbnail: SHFImages.productImage31,
      description:
      'This is a Product description for Tennis Racket. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      images: [SHFImages.productImage31, SHFImages.productImage29, SHFImages.productImage30, SHFImages.productImage28],
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),

    ///Furniture
    //bedroom
    ProductModel(
      id: '022',
      title: 'Quần thun Puma',
      stock: 15,
      price: 9500000,
      isFeatured: true,
      thumbnail: SHFImages.productImage32,
      description:
      'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      images: [SHFImages.productImage43, SHFImages.productImage44, SHFImages.productImage45, SHFImages.productImage46],
      salePrice: 60000,
      sku: 'ABR4568',
      categoryId: '17',
      productAttributes: [
        ProductAttributeModel(name: 'Color', values: ['Black', 'Grey', 'Brown']),
        ProductAttributeModel(name: 'Size', values: ['X', 'M', 'L']),
      ],
      productVariations: [
        ProductVariationModel(
            id: '1',
            stock: 16,
            price: 360000,
            salePrice: 126000,
            image: SHFImages.productImage32,
            description:
            'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
            attributeValues: {'Color': 'Brown', 'Size': 'L'}),
        ProductVariationModel(
            id: '2', stock: 15, price: 35000, image: SHFImages.productImage45, attributeValues: {'Color': 'Brown', 'Size': 'M'}),
        ProductVariationModel(
            id: '3', stock: 14, price: 34000, image: SHFImages.productImage46, attributeValues: {'Color': 'Brown', 'Size': 'X'}),
        ProductVariationModel(
            id: '4', stock: 13, price: 33000, image: SHFImages.productImage43, attributeValues: {'Color': 'Black', 'Size': 'M'}),
        ProductVariationModel(
            id: '5', stock: 12, price: 32000, image: SHFImages.productImage43, attributeValues: {'Color': 'Black', 'Size': 'L'}),
        ProductVariationModel(
            id: '6', stock: 11, price: 31000, image: SHFImages.productImage44, attributeValues: {'Color': 'Grey', 'Size': 'M'}),
      ],
      productType: ProductType.variable.toString(),
    ),
    ProductModel(
      id: '023',
      title: 'Áo thun Puma',
      stock: 15,
      price: 25000,
      thumbnail: SHFImages.productImage33,
      description:
      'This is a Product description for Side Table Lamp. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '17',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '024',
      title: 'Kính mát Herman Miller',
      stock: 15,
      price: 25000,
      thumbnail: SHFImages.productImage34,
      description:
      'This is a Product description for Bedroom Sofa. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '2', image: SHFImages.hermanMillerLogo, name: 'Herman Miller'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '23',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '025',
      title: 'Kính râm Herman Miller',
      stock: 15,
      price: 56000,
      thumbnail: SHFImages.productImage35,
      description:
      'This is a Product description for Bedroom Wardrobe. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '2', image: SHFImages.hermanMillerLogo, name: 'Herman Miller'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '24',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Kitchen
    ProductModel(
      id: '026',
      title: 'Quần jean Addidas',
      stock: 15,
      price: 1012000,
      thumbnail: SHFImages.productImage36,
      description:
      'This is a Product description for Kitchen Counter. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '13',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '027',
      title: 'Quần sọt Addidas',
      stock: 15,
      price: 1012000,
      thumbnail: SHFImages.productImage37,
      description:
      'This is a Product description for Dinning Table. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '16',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '028',
      title: 'Quần lưỡi trai Adidas',
      stock: 15,
      price: 987000,
      thumbnail: SHFImages.productImage38,
      description:
      'This is a Product description for Refrigerator. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '1', image: SHFImages.adidasLogo, name: 'Adidas'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '22',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Office
    ProductModel(
      id: '029',
      title: 'Áo da Zara',
      stock: 15,
      price: 150000,
      thumbnail: SHFImages.productImage39,
      description:
      'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'Zara'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '9',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '030',
      title: 'Áo khoác zara',
      stock: 15,
      price: 140000,
      thumbnail: SHFImages.productImage40,
      description:
      'This is a Product description for Office Chair. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '6', image: SHFImages.zaraLogo, name: 'Zara'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '11',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '031',
      title: 'Quần kaki Herman Miller',
      stock: 15,
      price: 360000,
      thumbnail: SHFImages.productImage41,
      description:
      'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '2', image: SHFImages.hermanMillerLogo, name: 'Herman Miller'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '14',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '032',
      title: 'Quần thể thao Herman Miller',
      stock: 15,
      price: 400000,
      thumbnail: SHFImages.productImage42,
      description:
      'This is a Product description for Office Desk. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '2', image: SHFImages.hermanMillerLogo, name: 'Herman Miller'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '15',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),

    ProductModel(
      id: '033',
      title: 'Giày Jordan new 2024',
      stock: 15,
      price: 400000,
      thumbnail: SHFImages.productImage48,
      description:
      'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '3', image: SHFImages.jordanLogo, name: 'Jordan'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '034',
      title: 'Giày Jordan new 2023',
      stock: 15,
      price: 400000,
      thumbnail: SHFImages.productImage49,
      description:
      'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '3', image: SHFImages.jordanLogo, name: 'Jordan'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '20',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '035',
      title: 'Mũ bucket Puma',
      stock: 15,
      price: 400000,
      thumbnail: SHFImages.productImage50,
      description:
      'This is a Product description for Acer Laptop. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '21',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    //Mobiles
    ProductModel(
      id: '036',
      title: 'Mũ lưỡi trai Puma',
      stock: 15,
      price: 999000,
      thumbnail: SHFImages.productImage51,
      description:
      'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '22',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
    ProductModel(
      id: '037',
      title: 'Kính mát Puma',
      stock: 15,
      price: 999000,
      thumbnail: SHFImages.productImage52,
      description:
      'This is a Product description for Iphone. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      // saleprice: 400000,1
      sku: 'ABR4568',
      categoryId: '23',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),

    ProductModel(
      id: '038',
      title: 'Kính râm Puma',
      stock: 15,
      price: 480,
      isFeatured: true,
      thumbnail: SHFImages.productImage14,
      description:
      'This is a Product description for iphone 8. There are more things that can be added but i am just practicing and nothing else.',
      brand: BrandModel(id: '5', image: SHFImages.pumaLogo, name: 'Puma'),
      images: [SHFImages.productImage15, SHFImages.productImage16, SHFImages.productImage17, SHFImages.productImage14],
      salePrice: 380000,
      sku: 'ABR4568',
      categoryId: '24',
      productAttributes: [
        ProductAttributeModel(name: 'Size', values: ['L', 'M']),
        ProductAttributeModel(name: 'Color', values: ['Green', 'Red', 'Blue']),
      ],
      productType: ProductType.single.toString(),
    ),
  ];

  /// -- Sorting Filters for search
  static final sortingFilters = [
    SortFilterModel(id: '1', name: 'Tên'),
    SortFilterModel(id: '2', name: 'Giá thấp đến cao'),
    SortFilterModel(id: '3', name: 'Phổ biến nhất'),
    SortFilterModel(id: '4', name: 'Giá cao đến thấp'),
    SortFilterModel(id: '5', name: 'Mới nhất'),
    SortFilterModel(id: '6', name: 'Phù hợp nhất'),
  ];

  /// -- Product Reviews
  static final List<ProductReviewModel> productReviews = [
    ProductReviewModel(
      id: '01',
      userId: '001',
      userName: 'John Doe',
      rating: 4.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: SHFImages.userProfileImage2,
      comment: 'The user interface of the app is quite intuitive. I was able to navigate and make purchases seamlessly. Great job!',
      companyComment:
      'Thank you for your kind words, John! We are delighted to hear about your smooth experience with the app. We always strive to offer an intuitive interface for our users. Stay tuned for more updates!',
    ),
    ProductReviewModel(
      id: '02',
      userId: '002',
      userName: 'Sophia Wilson',
      rating: 3.5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: SHFImages.userProfileImage1,
      comment:
      'I am genuinely impressed with the app design and the variety of products available. The filter and sort features have made shopping so much easier for me!',
      companyComment:
      'Thank you so much, Sophia! We are thrilled to hear you are enjoying the app and finding the features useful. Our goal is to make your shopping experience as efficient and pleasant as possible. Keep exploring, and happy shopping!',
    ),
    ProductReviewModel(
      id: '03',
      userId: '003',
      userName: 'Alex Brown',
      rating: 5,
      timestamp: DateTime.now(),
      companyTimestamp: DateTime.now(),
      userImageUrl: SHFImages.userProfileImage3,
      comment: 'The app is pretty fast, and the product recommendations are on point! I would love to see more features in the future.',
      companyComment:
      'Thanks for the feedback, Alex! We are thrilled to hear you enjoyed the speed and recommendations. We are constantly working on introducing new features, so keep an eye out for the next update!',
    ),
  ];
}

class SortFilterModel {
  String id;
  String name;

  SortFilterModel({required this.id, required this.name});
}
