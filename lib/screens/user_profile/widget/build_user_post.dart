import 'package:flutter/material.dart';
import 'package:instagram_clone/core/core_export.dart';

import '../../../models/user.dart';

class BuildUsersPost extends StatelessWidget {
  final AsyncSnapshot<Usermodels> snap;

  const BuildUsersPost({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: 20,
      primary: false,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 1.5,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return CustomCachedNetworkImage(
          context: context,
          url: snap.data!.image,
        );
      },
    );
  }
}
