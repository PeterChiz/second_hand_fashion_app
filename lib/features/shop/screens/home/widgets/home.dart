
import 'package:flutter/material.dart';
import '../../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../../common/widgets/texts/section_heading.dart';
import '../../../../../utils/constants/sizes.dart';
import 'home_appbar.dart';
import 'home_categories.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ///Header
            SHFPrimaryHeaderContainer(
              child: Column(
                children: [
                  ///Appbar
                  SHFHomeAppBar(),
                  SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Searchbar
                  SHFSearchContainer(text: 'Search in Store'),
                  SizedBox(
                    height: SHFSizes.spaceBtwSections,
                  ),

                  ///Categories
                  Padding(
                    padding: EdgeInsets.only(left: SHFSizes.defaultSpace),
                    child: Column(
                      children: [
                        ///Heading
                        SHFSectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(
                          height: SHFSizes.spaceBtwItems,
                        ),

                        ///Categories
                        SHFHomeCategories(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


