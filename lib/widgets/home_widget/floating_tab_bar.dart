import 'package:flutter/material.dart';
import 'package:shopping_app/util/constance/colors.dart';

class FloatingTabBar extends SliverPersistentHeaderDelegate {
  FloatingTabBar(this._tabBar);
  final TabBar _tabBar;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColor.backgroundColor,
        child: _tabBar,
      );

  @override
  double get maxExtent => _tabBar.preferredSize.height + 10;

  @override
  double get minExtent => _tabBar.preferredSize.height + 10;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
