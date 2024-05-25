import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_app/controller/cart_bloc/cart_bloc.dart';
import 'package:shopping_app/controller/total_amount_bloc/total_amount_bloc.dart';
import 'package:shopping_app/model/product_model.dart';
import 'package:shopping_app/util/constance/colors.dart';
import 'package:shopping_app/util/constance/text_style.dart';
import 'package:shopping_app/view/screen_details.dart';

class ProductGridViewWidget extends StatelessWidget {
  final List<ProductModel> productList;
  const ProductGridViewWidget({super.key, required this.productList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: productList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
      itemBuilder: (context, index) {
        final data = productList[index];
        return InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ScreenDetails(data: data))),
          child: Container(
            height: 120,
            width: double.maxFinite,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                children: [
                  Expanded(
                      flex: 7,
                      child: CachedNetworkImage(
                        width: double.maxFinite,
                        imageUrl: data.image,
                        placeholder: (context, url) => Shimmer.fromColors(
                          baseColor: AppColor.extraLightGrey,
                          highlightColor: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data.image),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                      )),
                  Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 15,
                              child: Text(
                                data.title,
                                style: AppText.smallDark,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    '₹ ${data.price.toString()}',
                                    style: AppText.mediumdark,
                                  ),
                                ),
                                Expanded(
                                    flex: 2,
                                    child: BlocListener<CartBloc, CartState>(
                                      listener: (context, state) {
                                        if (state
                                            is ProductAddedToCartSuccessState) {
                                          context
                                              .read<CartBloc>()
                                              .add(GetCartedProduct());
                                          context
                                              .read<TotalAmountBloc>()
                                              .add(GetCartItemsTotolAmount());
                                        }
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          context.read<CartBloc>().add(
                                              AddProductToCartEvent(
                                                  data: data, quantity: 1));

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                                  content: Text(
                                                      'Product added to cart')));
                                        },
                                        child: const Icon(
                                          Icons.add_shopping_cart_rounded,
                                          size: 22,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
