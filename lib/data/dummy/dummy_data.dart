import 'package:second_hand_fashion_app/features/shop/models/category_model.dart';
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
    CategoryModel(id: '1', name: SHFImages.sportIcon, image: 'Sports', isFeatured: true),
    CategoryModel(id: '2', name: SHFImages.furnitureIcon, image: 'Furniture', isFeatured: true),
    CategoryModel(id: '3', name: SHFImages.electronicsIcon, image: 'Electronics', isFeatured: true),
    CategoryModel(id: '4', name: SHFImages.clothIcon, image: 'Cloth', isFeatured: true),
    CategoryModel(id: '5', name: SHFImages.animalIcon, image: 'Animal', isFeatured: true),
    CategoryModel(id: '6', name: SHFImages.shoeIcon, image: 'Shoe', isFeatured: true),
    CategoryModel(id: '7', name: SHFImages.cosmeticsIcon, image: 'Cosmetics', isFeatured: true),
    CategoryModel(id: '14', name: SHFImages.jeweleryIcon, image: 'Jewelery', isFeatured: true),

    ///Subcategories
    CategoryModel(id: '8', name: SHFImages.sportIcon, image: 'Sport Shoes',parentId: '1', isFeatured: true),
    CategoryModel(id: '9', name: SHFImages.sportIcon, image: 'Track suits',parentId: '1', isFeatured: true),
    CategoryModel(id: '10', name: SHFImages.sportIcon, image: 'Sport Equipment',parentId: '1', isFeatured: true),

    ///Furniture
    CategoryModel(id: '11', name: SHFImages.furnitureIcon, image: 'Bedroom furniture', parentId: '5', isFeatured: true),
    CategoryModel(id: '12', name: SHFImages.furnitureIcon, image: 'Kitchen furniture',parentId: '5', isFeatured: true),
    CategoryModel(id: '13', name: SHFImages.furnitureIcon, image: 'Office furniture',parentId: '5', isFeatured: true),

    ///Electronic
    CategoryModel(id: '14', name: SHFImages.electronicsIcon, image: 'Laptop', parentId: '2',isFeatured: true),
    CategoryModel(id: '15', name: SHFImages.electronicsIcon, image: 'Mobile',parentId: '2', isFeatured: true),

    CategoryModel(id: '16', name: SHFImages.clothIcon, image: 'Shirts', parentId: '3',isFeatured: true),

  ];
}
