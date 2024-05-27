import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:finfresh_machin_task/model/product_model.dart';
import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:finfresh_machin_task/util/constance/text_style.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductGridViewWidget extends StatelessWidget {
  final List<ProductModel> productList;
  final bool isOffline;
  const ProductGridViewWidget(
      {super.key, required this.productList, this.isOffline = false});

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
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Expanded(
                    flex: 7,
                    child: isOffline
                        ? Image.file(
                            File(
                              data.localImagePath!,
                            ),
                            width: double.maxFinite,
                          )
                        : CachedNetworkImage(
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
                                child: InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    Icons.add_shopping_cart_rounded,
                                    size: 22,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
