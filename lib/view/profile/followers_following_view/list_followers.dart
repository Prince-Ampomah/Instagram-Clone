import 'package:flutter/material.dart';

import '../../../core/widgets/cus_circular_progressbar.dart';
import '../../../model/user_model/user_model.dart';
import '../../../repository/respository_implementation/database_implementation.dart';
import 'list_followers_item.dart';

class ListFollowers extends StatelessWidget {
  const ListFollowers({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirestoreDBImpl.getEitherFollowersOrFollowingUsersData(
        userModel.listOfFollowers!,
      ),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if (snapshot.hasData) {
          List<UserModel> users = snapshot.data!.map((user) => user).toList();

          return ListFollowerItem(followersUsers: users);
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CustomCircularProgressBar());
        }

        if (snapshot.hasError) {
          Center(child: Text(snapshot.error.toString()));
        }

        return Center(child: Text(snapshot.data.toString()));
      },
    );
  }
}
