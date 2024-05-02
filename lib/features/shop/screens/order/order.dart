import 'package:flutter/material.dart';
import 'package:second_hand_fashion_app/common/widgets/appbar/appbar.dart';
import 'package:second_hand_fashion_app/features/shop/screens/order/widgets/order_list.dart';
import 'package:second_hand_fashion_app/utils/constants/sizes.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///Appbar
      appBar: SHFAppBar(
        title: Text(
          'Đơn hàng của tôi',
          style: Theme.of(context).textTheme.headlineSmall
        ),
        showBackArrow: true,
      ),
      body: const Padding(
          padding: EdgeInsets.all(SHFSizes.defaultSpace),

        ///Orders
          child: SHFOrderListItems(),

      ),
    );
  }
}
