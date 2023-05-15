import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class UsersOnlineView extends StatelessWidget {
  const UsersOnlineView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          ...List.generate(
            2,
            (index) {
              return const ListUsers();
            },
          ),
        ],
      ),
    );
  }
}

class ListUsers extends StatelessWidget {
  const ListUsers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

//     var currentUser = HiveServices.getUserBox().get(Const.currentUser);
//     List<dynamic> f = currentUser!.listOfFollowing!.map((data) {
//       logger.d(data);
//       return data;
//     }).toList();

// currentUser!.listOfFollowing.
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.symmetric(horizontal: 7),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 0.1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset(Const.princeImage),
              ),
            ),
            Positioned(
              top: size.height * 0.065,
              left: size.width * 0.17,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: const Color(0xFF4BCD1C),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 1.5,
                  ),
                ),
              ),
            )
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 5),
          child: Text(
            'userHandle',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
