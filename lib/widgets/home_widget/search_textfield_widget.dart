import 'package:flutter/material.dart';

import '../../util/constance/text_style.dart';

class SearchTextFieldWidget extends StatelessWidget {
  final TextEditingController searchController = TextEditingController();

  SearchTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex: 10,
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: TextFormField(
                readOnly: true,
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8),
                  hintText: 'Search here',
                  hintStyle: AppText.smallDark,
                  suffixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(color: Colors.white)),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 1,
              child: Container(
                  alignment: Alignment.centerRight,
                  child: const Icon(Icons.mic_none_rounded)))
        ],
      ),
    );
  }
}
