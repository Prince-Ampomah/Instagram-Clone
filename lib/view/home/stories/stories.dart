import 'package:flutter/material.dart';

import '../../../core/constants/constants.dart';

class Stories extends StatelessWidget {
  const Stories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          10,
          (index) {
            if (index == 0) {
              // your story
              return const YourStory();
            }
            // other stories
            return const OtherStories();
          },
        ),
      ),
    );
  }
}

class YourStory extends StatelessWidget {
  const YourStory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 75,
              width: 75,
              margin: const EdgeInsets.all(8.0),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, border: Border.all()),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset(Const.princeImage),
              ),
            ),
            Positioned(
              top: height * 0.07,
              left: width * 0.16,
              child: Container(
                height: 22,
                width: 22,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        const Text('Your story')
      ],
    );
  }
}

class OtherStories extends StatelessWidget {
  const OtherStories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 75,
          width: 75,
          margin: const EdgeInsets.all(8.0),
          decoration:
              BoxDecoration(shape: BoxShape.circle, border: Border.all()),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(70),
            child: Image.asset(Const.princeImage),
          ),
        ),
        const Text('username')
      ],
    );
  }
}
