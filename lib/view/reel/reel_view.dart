import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../core/theme/theme.dart';
import '../../core/widgets/cus_circular_image.dart';
import 'dart:math' as math;

import '../../core/constants/constants.dart';

class ReelView extends StatelessWidget {
  const ReelView({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: 10,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Image.asset(
              Const.reelImage,
              height: size.height,
              width: size.width,
            ),
            const Align(
              alignment: Alignment.center,
              child: Icon(
                Icons.favorite,
                color: Colors.red,
                size: 100,
              ),
            ),
            const ReelReactionButtons(),
            const ReelUserProfile(),
          ],
        );
      },
    );
  }
}

class ReelReactionButtons extends StatelessWidget {
  const ReelReactionButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 30,
                  child: Image.asset(
                    Const.instragramfavoriteIcon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '20k',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                SizedBox(
                  height: 25,
                  child: Image.asset(
                    Const.instragramCommentIcon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  '320',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 25,
              child: Image.asset(
                Const.instragramSendIcon,
                color: Colors.white,
              ),
            ),
            // const Icon(
            //   Icons.near_me_outlined,
            //   size: 35,
            //   color: Colors.white,
            // ),
            const SizedBox(height: 20),
            const Icon(
              Icons.more_vert_outlined,
              size: 35,
              color: Colors.white,
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.music_note_outlined,
              size: 30,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}

class ReelUserProfile extends StatelessWidget {
  const ReelUserProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularImageContainer(
                  border: Border.all(
                    width: 1.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'User Data',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.whiteColor),
                ),
                const SizedBox(width: 4),
                Text(
                  '4w',
                  style: Theme.of(context)
                      .textTheme
                      .labelMedium!
                      .copyWith(color: AppColors.greyColor),
                ),
                const SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    side: MaterialStateProperty.all(
                      const BorderSide(color: AppColors.whiteColor),
                    ),
                  ),
                  child: Text(
                    'Follow',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remote Jobs - requires no talking',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.sort_rounded,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'sarkcess music prod...',
                        style:
                            Theme.of(context).textTheme.labelMedium!.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
