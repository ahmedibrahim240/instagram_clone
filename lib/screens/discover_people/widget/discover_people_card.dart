import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/screens/screens_export.dart';

class BuildDiscoverPeopleCard extends StatelessWidget {
  final Usermodels user;
  const BuildDiscoverPeopleCard({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: defaultSize * 17.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kSecondaryColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleImge(
            radius: 50,
            width: 100,
            height: 100,
            url: user.image,
          ),
          Column(
            children: [
              CustomText(
                text: user.userName!,
                fontSize: 12,
                color: kPrimaryColor,
                alignment: Alignment.center,
              ),
              CustomText(
                text: user.name!,
                fontSize: 12,
                color: kSecondaryColor,
                alignment: Alignment.center,
              ),
            ],
          ),
          FollowButtom(
            user: user,
            margin: const EdgeInsets.symmetric(
              horizontal: 5,
              vertical: 5,
            ),
            cardMargin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
          ),
        ],
      ),
    );
  }
}
