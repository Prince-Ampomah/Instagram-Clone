import 'package:flutter/material.dart';
import 'package:instagram_clone/core/widgets/cus_appbar.dart';

import '../../../core/widgets/cus_cached_image.dart';

class ChatImageDetails extends StatelessWidget {
  const ChatImageDetails({super.key, this.chatMedia});

  final List<dynamic>? chatMedia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(implyLeading: true),
        body: GridView(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: chatMedia!.length != 1 ? 2 : 1,
            childAspectRatio: .7,
          ),
          children: List.generate(
            chatMedia!.length,
            (index) {
              return Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 2,
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: CustomCachedImage(
                    imageUrl: chatMedia![index]!,
                    fit: BoxFit.fitHeight,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
