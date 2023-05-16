import 'package:flutter/material.dart';
import 'package:instagram_clone/core/utils/helper_functions.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';
import 'package:instagram_clone/view/profile/followers_and_following_view.dart';

class PostFollowerAndFollowing extends StatelessWidget {
  const PostFollowerAndFollowing({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              '${userModel.numberOfPost}',
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
              FollowersAndFollowingView(userModel: userModel),
            );
          },
          child: Column(
            children: [
              Text(
                '${userModel.numberOfFollowers}',
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
              FollowersAndFollowingView(userModel: userModel),
            );
          },
          child: Column(
            children: [
              Text(
                '${userModel.numberOfFollowing}',
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
