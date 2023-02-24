import 'package:flutter/material.dart';

import '../pages/order.dart';
import 'bottom_navbar.dart';

class orden_list extends StatelessWidget {
  const orden_list({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) => const Order(),
        ),
      ),
      child: const BottomNavBar(),
    );
  }
}
