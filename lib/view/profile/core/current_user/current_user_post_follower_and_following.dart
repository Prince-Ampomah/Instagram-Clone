import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/view/profile/followers_following_view/followers_and_following_view.dart';

import '../../../../model/user_model/user_model.dart';

class CurrentUserPostFollowersFollowing extends StatelessWidget {
  const CurrentUserPostFollowersFollowing({
    super.key,
    required this.userModel,
  });

  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              '${userModel?.numberOfPost}',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Text('Posts'),
          ],
        ),
        const SizedBox(width: 30),
        InkWell(
          onTap: () {
            sendToPage(
              context,
              FollowersAndFollowingView(
                userModel: userModel,
                pageIndex: 0,
              ),
            );
          },
          child: Column(
            children: [
              Text(
                '${userModel?.listOfFollowers!.length}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Text('Followers'),
            ],
          ),
        ),
        const SizedBox(width: 30),
        InkWell(
          onTap: () {
            sendToPage(
              context,
              FollowersAndFollowingView(
                userModel: userModel,
                pageIndex: 1,
              ),
            );
          },
          child: Column(
            children: [
              Text(
                '${userModel?.listOfFollowing!.length}',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Text('Following'),
            ],
          ),
        ),
      ],
    );
  }
}
