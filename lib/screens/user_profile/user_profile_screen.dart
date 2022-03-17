import 'package:flutter/material.dart';
import '../screens_export.dart';

class UserProfileScrean extends StatelessWidget {
  final String? uuid;
  const UserProfileScrean({Key? key, this.uuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileBody(
      uuid: uuid ?? authControllers.getcurrentUser.id!,
    );
  }
}
