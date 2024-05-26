import 'dart:async';
import 'package:finfresh_machin_task/controller/product_bloc/product_bloc.dart';
import 'package:finfresh_machin_task/util/constance/colors.dart';
import 'package:finfresh_machin_task/util/constance/text_style.dart';
import 'package:finfresh_machin_task/util/notification/notification.dart';
import 'package:finfresh_machin_task/widgets/home_widget/electronics_product.dart';
import 'package:finfresh_machin_task/widgets/home_widget/jewelery_product.dart';
import 'package:finfresh_machin_task/widgets/home_widget/popular_product.dart';
import 'package:finfresh_machin_task/widgets/home_widget/search_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';
import '../util/constance/const_items.dart';
import '../widgets/home_widget/clothing_product.dart';
import '../widgets/home_widget/floating_tab_bar.dart';

class ScreenHome extends StatefulWidget {
  ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  final Notificationservices notification = Notificationservices();
  final ValueNotifier<bool> isOnline = ValueNotifier<bool>(false);
  late StreamSubscription<InternetStatus> internetSubscription;

  @override
  void initState() {
    super.initState();
    notification.initializationNotifications();
    internetSubscription = InternetConnection().onStatusChange.listen((status) {
      isOnline.value = status == InternetStatus.connected;
      dataCheck(context);
    });
  }

  @override
  void dispose() {
    internetSubscription.cancel();
    super.dispose();
  }

  void dataCheck(BuildContext context) {
    if (isOnline.value) {
      notification.sendNotification('Online', 'You are online');
      context.read<ProductBloc>().add(GetProducttsEvent());
    } else {
      notification.sendNotification('Network Error', 'You are offline');
      print('hello hai how are you ');
      context
          .read<ProductBloc>()
          .add(GetOfflineProductDetailsInDatabaseEvent());
    }
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Scaffold(
        drawer: const Drawer(
          child: CircleAvatar(),
        ),
        backgroundColor: AppColor.extraLightGrey,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
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
        ),
        body: DefaultTabController(
          length: 4,
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                leading: const SizedBox(),
                collapsedHeight: 190,
                expandedHeight: 190,
                flexibleSpace: _header(context),
              ),
              _tabBar()
            ],
            body: _tabBarView(),
          ),
        ),
      ),
    );
  }

  TabBarView _tabBarView() {
    return const TabBarView(
      children: [
        PopularProductWidget(),
        ClothingProductWidget(),
        ElectronicsItemsWidget(),
        JeweleryItemWidget()
      ],
    );
  }

  Container _header(BuildContext context) {
    return Container(
      color: AppColor.extraLightGrey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            'Choose Brand',
            style: AppText.mediumdark,
          ),
        ),
        SizedBox(
          height: 160,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => const SizedBox(
                width: 10,
              ),
              itemCount: ConstItems.products.length,
              itemBuilder: (context, index) {
                final data = ConstItems.products[index];
                return Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(children: [
                    Container(
                      height: 100,
                      width: 120,
                      decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          image: DecorationImage(
                            image: AssetImage(data['image']),
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text(
                      data['name'],
                      style: AppText.mediumdark,
                    ),
                  ]),
                );
              },
            ),
          ),
        )
      ]),
    );
  }

  SliverPersistentHeader _tabBar() {
    return SliverPersistentHeader(
      delegate: FloatingTabBar(
        TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicator: DotIndicator(
            color: Colors.black,
            distanceFromCenter: 16,
            radius: 3,
            paintingStyle: PaintingStyle.fill,
          ),
          indicatorPadding: const EdgeInsets.symmetric(vertical: 2),
          labelColor: Colors.black,
          labelStyle: AppText.mediumdark.copyWith(letterSpacing: .5),
          unselectedLabelColor: AppColor.textSecondary,
          padding: const EdgeInsets.symmetric(vertical: 8),
          tabs: const [
            Tab(text: 'Popular'),
            Tab(text: 'Clothing'),
            Tab(text: 'Electronic'),
            Tab(text: 'Jewelery'),
          ],
        ),
      ),
      floating: true,
      pinned: true,
    );
  }
}
