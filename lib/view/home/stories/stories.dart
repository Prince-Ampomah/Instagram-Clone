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
            return Column(
              children: [
                Container(
                  height: 75,
                  width: 75,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all()),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(70),
                    child: Image.asset(Const.princeImage),
                  ),
                ),
                const Text('Your story')
              ],
            );
          },
        ),
      ),
    );
  }
}
