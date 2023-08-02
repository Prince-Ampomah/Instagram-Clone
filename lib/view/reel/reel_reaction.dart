import 'package:flutter/material.dart';
import 'package:instagram_clone/app_state.dart';
import 'package:instagram_clone/controller/reel_controller/reel_like_controller.dart';
import 'package:instagram_clone/core/constants/constants.dart';
import 'package:instagram_clone/core/theme/app_colors.dart';
import 'package:instagram_clone/model/reel_model/reel_model.dart';
import 'package:instagram_clone/model/user_model/user_model.dart';

class ReelReactionButtons extends StatefulWidget {
  const ReelReactionButtons({
    super.key,
    required this.reelModel,
  });

  final ReelModel reelModel;

  @override
  State<ReelReactionButtons> createState() => _ReelReactionButtonsState();
}

class _ReelReactionButtonsState extends State<ReelReactionButtons> {
  late UserModel userModel;

  @override
  void initState() {
    super.initState();
    userModel = AppState.currentUser!;
  }

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
                GestureDetector(
                  onTap: () => ReelLikeController.instance
                      .toggleLike(widget.reelModel.id!),
                  child: Icon(
                    widget.reelModel.isLikedBy!.contains(userModel.userId)
                        ? Icons.favorite
                        : Icons.favorite_outline_rounded,
                    size: 35,
                    color:
                        widget.reelModel.isLikedBy!.contains(userModel.userId)
                            ? Colors.red
                            : Colors.white,
                  ),
                ),
                const SizedBox(height: 5),
                if (widget.reelModel.isLikedBy!.isNotEmpty)
                  Text(
                    widget.reelModel.isLikedBy!.length.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: AppColors.whiteColor),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {},
              child: Column(
                children: [
                  SizedBox(
                    height: 25,
                    child: Image.asset(
                      Const.instragramCommentIcon,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (widget.reelModel.comment != 0)
                    Text(
                      widget.reelModel.comment.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium!
                          .copyWith(color: AppColors.whiteColor),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 25,
              child: Image.asset(
                Const.instragramSendIcon,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(
              Icons.more_vert_outlined,
              size: 33,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
