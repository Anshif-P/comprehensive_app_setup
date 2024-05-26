import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_gridview_widget.dart';

class ClothingProductWidget extends StatelessWidget {
  const ClothingProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductFetchSuccessState) {
          final productList = state.productList
              .where((element) =>
                  element.category == "women's clothing" ||
                  element.category == "men's clothing")
              .toList();
          return ProductGridViewWidget(
            productList: productList,
          );
        } else if (state is OfflineProductFetchSuccessState) {
          print('--------------------- local product fetch success state');
          final productList = state.productList
              .where((element) =>
                  element.category == "women's clothing" ||
                  element.category == "men's clothing")
              .toList();
          return ProductGridViewWidget(
            productList: productList,
            isOffline: true,
          );
        } else if (state is ProductFetchLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LocalProductNotFoundState) {
          return Center(
            child: Text("Turn on you data to show product information"),
          );
        }
        return const SizedBox();
      }),
    );
  }
}
