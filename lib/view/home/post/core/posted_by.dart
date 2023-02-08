import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';

class PostedBy extends StatelessWidget {
  const PostedBy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                height: 35,
                width: 35,
                margin: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, border: Border.all()),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(70),
                  child: Image.asset(Const.userImage),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('citi973fm'),
                      const SizedBox(width: 5),
                      Image.asset(
                        Const.instragramVerifiedIcon,
                        height: 15,
                        width: 15,
                      ),

                      // Container(
                      //   height: 15,
                      //   width: 15,
                      //   decoration: const BoxDecoration(
                      //       color: Colors.blue,
                      //       shape: BoxShape.circle),
                      //   child: ClipRRect(
                      //     borderRadius: BorderRadius.circular(20),
                      //     child: const Icon(
                      //       Icons.check,
                      //       color: Colors.white,
                      //       size: 10,
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                  const Text('sponsored'),
                ],
              )
            ],
          ),
          const Spacer(),
          const Icon(Icons.more_vert)
        ],
      ),
    );
  }
}
