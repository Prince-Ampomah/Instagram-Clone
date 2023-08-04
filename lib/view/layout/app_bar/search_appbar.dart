import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/cus_text_field_container.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0.0,
      title: const SearchWidget(),
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: TextFieldContainer(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        color: AppColors.searchFieldColor,
        child: TextFormField(
          maxLines: 1,
          minLines: 1,
          textInputAction: TextInputAction.search,
          cursorColor: AppColors.blackColor,
          decoration: const InputDecoration(
            border: InputBorder.none,
            prefixIcon: Icon(
              Ionicons.search_outline,
            ),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
