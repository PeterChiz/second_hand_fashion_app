import 'package:second_hand_fashion_app/features/shop/models/brand_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_attribute_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_model.dart';
import 'package:second_hand_fashion_app/features/shop/models/product_variation_model.dart';
import 'package:second_hand_fashion_app/routes/routes.dart';
import 'package:second_hand_fashion_app/utils/constants/image_strings.dart';

import '../../features/shop/models/banner_model.dart';

class SHFDummyData {
  ///Banner
  static final List<BannerModel> banners = [
    BannerModel(
        imageUrl: SHFImages.banner1,
        targetScreen: SHFRoutes.order,
        active: false),
    BannerModel(
        imageUrl: SHFImages.banner2,
        targetScreen: SHFRoutes.cart,
        active: true),
    BannerModel(
        imageUrl: SHFImages.banner3,
        targetScreen: SHFRoutes.favourites,
        active: true),
    BannerModel(
        imageUrl: SHFImages.banner4,
        targetScreen: SHFRoutes.search,
        active: true),
    BannerModel(
        imageUrl: SHFImages.banner5,
        targetScreen: SHFRoutes.settings,
        active: true),
    BannerModel(
        imageUrl: SHFImages.banner6,
        targetScreen: SHFRoutes.userAddress,
        active: true),
    BannerModel(
        imageUrl: SHFImages.banner8,
        targetScreen: SHFRoutes.checkout,
        active: false),
  ];

  ///
  ///
  ///

  ///List of all Categories
  static final List<CategoryModel> categories = [
    CategoryModel(
        id: '1', name: SHFImages.sportIcon, image: 'Sports', isFeatured: true),
    CategoryModel(
        id: '2',
        name: SHFImages.furnitureIcon,
        image: 'Furniture',
        isFeatured: true),
    CategoryModel(
        id: '3',
        name: SHFImages.electronicsIcon,
        image: 'Electronics',
        isFeatured: true),
    CategoryModel(
        id: '4', name: SHFImages.clothIcon, image: 'Cloth', isFeatured: true),
    CategoryModel(
        id: '5', name: SHFImages.animalIcon, image: 'Animal', isFeatured: true),
    CategoryModel(
        id: '6', name: SHFImages.shoeIcon, image: 'Shoe', isFeatured: true),
    CategoryModel(
        id: '7',
        name: SHFImages.cosmeticsIcon,
        image: 'Cosmetics',
        isFeatured: true),
    CategoryModel(
        id: '14',
        name: SHFImages.jeweleryIcon,
        image: 'Jewelery',
        isFeatured: true),

    ///Subcategories
    CategoryModel(
        id: '8',
        name: SHFImages.sportIcon,
        image: 'Sport Shoes',
        parentId: '1',
        isFeatured: true),
    CategoryModel(
        id: '9',
        name: SHFImages.sportIcon,
        image: 'Track suits',
        parentId: '1',
        isFeatured: true),
    CategoryModel(
        id: '10',
        name: SHFImages.sportIcon,
        image: 'Sport Equipment',
        parentId: '1',
        isFeatured: true),

    ///Furniture
    CategoryModel(
        id: '11',
        name: SHFImages.furnitureIcon,
        image: 'Bedroom furniture',
        parentId: '5',
        isFeatured: true),
    CategoryModel(
        id: '12',
        name: SHFImages.furnitureIcon,
        image: 'Kitchen furniture',
        parentId: '5',
        isFeatured: true),
    CategoryModel(
        id: '13',
        name: SHFImages.furnitureIcon,
        image: 'Office furniture',
        parentId: '5',
        isFeatured: true),

    ///Electronic
    CategoryModel(
        id: '14',
        name: SHFImages.electronicsIcon,
        image: 'Laptop',
        parentId: '2',
        isFeatured: true),
    CategoryModel(
        id: '15',
        name: SHFImages.electronicsIcon,
        image: 'Mobile',
        parentId: '2',
        isFeatured: true),

    CategoryModel(
        id: '16',
        name: SHFImages.clothIcon,
        image: 'Shirts',
        parentId: '3',
        isFeatured: true),
  ];

  ///List of all products
  static final List<ProductModel> products = [
    ProductModel(
        id: '001',
        stock: 15,
        price: 135,
        title: 'Green Nike Sports shoe',
        thumbnail: SHFImages.productImage1,
        productType: 'ProductType.variable',
        isFeatured: true,
        description: 'Green Nike Sports shoe',
        brand: BrandModel(
            id: '1',
            name: 'Nike',
            image: SHFImages.nikeLogo,
            productsCount: 265,
            isFeatured: true),
        images: [
          SHFImages.productImage1,
          SHFImages.productImage23,
          SHFImages.productImage3,
          SHFImages.productImage4
        ],
        salePrice: 30,
        sku: 'ABR4689',
        categoryId: '1',
        productAttributes: [
          ProductAttributeModel(
              name: 'Color', values: ['Green', 'Black', 'Red']),
          ProductAttributeModel(
              name: 'Size', values: ['RU 30', 'RU 32', 'RU34']),
        ],
        productVariations: [
          ProductVariationModel(
              id: '1',
              attributeValues: {'Color': 'Green', 'Size': "RU 34"},
              stock: 34,
              price: 143,
              salePrice: 122,
              image: SHFImages.productImage3,
              description:
                  'Đây là sản phẩm đẹp nhất trong tất sản phẩm về áo thun hợp thời trang'),
          ProductVariationModel(
            id: '2',
            attributeValues: {'Color': 'Black', 'Size': "RU 13"},
            stock: 12,
            price: 123,
            image: SHFImages.productImage5,
          ),
          ProductVariationModel(
            id: '2',
            attributeValues: {'Color': 'Red', 'Size': "RU 22"},
            stock: 12,
            price: 123,
            image: SHFImages.productImage5,
          ),
          ProductVariationModel(
            id: '3',
            attributeValues: {'Color': 'Blue', 'Size': "RU 24"},
            stock: 0,
            price: 123,
            image: SHFImages.productImage5,
          ),
          ProductVariationModel(
            id: '4',
            attributeValues: {'Color': 'Green', 'Size': "RU 30"},
            stock: 12,
            price: 123,
            image: SHFImages.productImage5,
          ),
          ProductVariationModel(
            id: '5',
            attributeValues: {'Color': 'White', 'Size': "RU 31"},
            stock: 12,
            price: 123,
            image: SHFImages.productImage5,
          ),
          ProductVariationModel(
            id: '2',
            attributeValues: {'Color': 'Pink', 'Size': "RU 32"},
            stock: 0,
            price: 123,
            image: SHFImages.productImage5,
          ),
        ],
    ),
    //them product model vao
  ];
}
