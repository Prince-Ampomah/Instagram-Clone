import 'package:flutter/material.dart';

import '../../../../core/widgets/cus_read_more_text.dart';
import '../../../../model/user_model/user_model.dart';

class FullnameAndBio extends StatelessWidget {
  const FullnameAndBio({
    super.key,
    required this.userModel,
  });

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userModel?.fullname ?? 'full name',
            style: Theme.of(context)
                .textTheme
                .labelLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          if (userModel!.bio != null)
            CustomReadMore(
              text: userModel!.bio!,
              trimLines: 3,
            )
        ],
      ),
    );
  }
}
