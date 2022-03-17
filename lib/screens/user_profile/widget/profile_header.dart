import 'package:flutter/material.dart';
import 'package:instagram_clone/core/core_export.dart';

import '../../../models/user.dart';

class ProfileHeader extends StatelessWidget {
  final AsyncSnapshot<Usermodels> snap;

  const ProfileHeader({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleImge(
              radius: 50,
              height: 100,
              width: 100,
              url: snap.data!.image,
              boxFit: BoxFit.cover,
            ),
            buildStatColumn(number: "111", title: 'post'),
            buildStatColumn(
              number: snap.data!.followers!.length.toString(),
              title: 'Followers',
            ),
            buildStatColumn(
              number: snap.data!.following!.length.toString(),
              title: 'Following',
            ),
          ],
        ),
        SizedBox(height: defaultSize),
        CustomText(text: snap.data!.name!),
        SizedBox(height: defaultSize),
        if (snap.data!.bio!.isNotEmpty) ...[
          SizedBox(
            width: 200,
            child: CustomText(
              text: snap.data!.bio!,
              maxLines: 3,
              fontSize: 13,
            ),
          ),
          SizedBox(height: defaultSize * 2),
        ],
      ],
    );
  }

  buildStatColumn({required String number, required String title}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: number,
          fontSize: 14,
        ),
        const SizedBox(height: 10),
        CustomText(
          text: title,
          color: kBlueColor,
          fontSize: 16,
        ),
      ],
    );
  }
}
