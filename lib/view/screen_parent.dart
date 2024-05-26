import 'package:finfresh_machin_task/view/screen_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/constance/colors.dart';
import 'screen_home.dart';

class ScreenParentNavigation extends StatelessWidget {
  ScreenParentNavigation({super.key});

  final pageNotifier = ValueNotifier(0);

  final List<Widget> _screens = [
    const ScreenHome(),
    ScreenProfile(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: pageNotifier,
          builder: (context, value, _) => _screens[pageNotifier.value]),
      bottomNavigationBar: NavigationBar(pageNotifier: pageNotifier),
    );
  }
}

class NavigationBar extends StatelessWidget {
  const NavigationBar({super.key, required this.pageNotifier});
  final ValueNotifier<int> pageNotifier;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: pageNotifier,
        builder: (context, value, _) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: AppColor.lightGreyColor, width: 1))),
            padding: const EdgeInsets.only(top: 4),
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                bottomNavigationItems(
                  icon: CupertinoIcons.home,
                  label: 'Home',
                  onTap: () => pageNotifier.value = 0,
                  isSelected: pageNotifier.value == 0,
                ),
                bottomNavigationItems(
                  icon: CupertinoIcons.person,
                  label: 'Profile',
                  onTap: () => pageNotifier.value = 1,
                  isSelected: pageNotifier.value == 1,
                ),
              ],
            ),
          );
        });
  }

  Expanded bottomNavigationItems({
    required String label,
    required IconData icon,
    required VoidCallback onTap,
    bool addTextcolor = false,
    bool hideIcon = false,
    bool isSelected = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          child: Column(
            children: [
              const SizedBox(height: 5),
              hideIcon
                  ? const SizedBox(height: 25)
                  : Icon(
                      icon,
                      color: isSelected ? Colors.black : Colors.grey.shade500,
                    ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(
                  color: addTextcolor == false
                      ? isSelected
                          ? Colors.black
                          : Colors.grey.shade500
                      : Colors.red,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
