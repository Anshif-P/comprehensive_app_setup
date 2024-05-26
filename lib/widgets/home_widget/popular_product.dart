import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'product_gridview_widget.dart';

class PopularProductWidget extends StatelessWidget {
  const PopularProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductFetchSuccessState) {
          return ProductGridViewWidget(
            productList: state.productList,
          );
        } else if (state is OfflineProductFetchSuccessState) {
          final productList = state.productList
              .where((element) =>
                  element.category == "women's clothing" ||
                  element.category == "men's clothing")
              .toList();
          return ProductGridViewWidget(
            productList: productList,
            isOffline: true,
          );
        }
        return const SizedBox();
      }),
    );
  }
}
