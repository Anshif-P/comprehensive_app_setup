import 'package:flutter/material.dart';
import 'package:shopping_app/util/constance/colors.dart';

import 'search_textfield_widget.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.extraLightGrey,
      leading: Builder(
        builder: (context) => InkWell(
          onTap: () => Scaffold.of(context).openDrawer(),
          child: const Icon(
            Icons.menu,
            size: 30,
          ),
        ),
      ),
      actions: const [
        Icon(Icons.qr_code_scanner_outlined),
        SizedBox(
          width: 15,
        ),
        Icon(Icons.shopping_bag_outlined),
        SizedBox(
          width: 10,
        )
      ],
      bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SearchTextFieldWidget(),
              const SizedBox(
                height: 20,
              ),
            ],
          )),
    );
  }
}
