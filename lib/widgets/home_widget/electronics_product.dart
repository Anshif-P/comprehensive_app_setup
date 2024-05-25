import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../controller/product_bloc/product_bloc.dart';
import 'home_widget/product_gridview_widget.dart';

class ElectronicsItemsWidget extends StatelessWidget {
  const ElectronicsItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductFetchSuccessState) {
          final productList = state.productList
              .where((element) => element.category == 'electronics')
              .toList();
          return ProductGridViewWidget(
            productList: productList,
          );
        }
        return const SizedBox();
      }),
    );
  }
}
