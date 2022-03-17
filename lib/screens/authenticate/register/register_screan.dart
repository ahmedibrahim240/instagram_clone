import 'package:flutter/material.dart';
import 'package:instagram_clone/core/core_export.dart';
import 'package:instagram_clone/screens/authenticate/authenticate_export.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: <Widget>[
          _appBar(),
          _image(),
          buidBody(),
        ],
      ),
    );
  }

  _appBar() => SliverAppBar(
        floating: true,
        pinned: true,
        toolbarHeight: defaultSize * 9,
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: defaultSize * 2),
            const AuthLogo(),
            SizedBox(height: defaultSize),
          ],
        ),
      );
  _image() => SliverAppBar(
        floating: true,
        toolbarHeight: defaultSize * 17,

        centerTitle: true,
        title: Column(
          children: [
            SizedBox(height: defaultSize),
            const Center(
              child: PickUserImage(),
            ),
          ],
        ),

        //  LayoutBuilder(
      );
  buidBody() {
    return SliverToBoxAdapter(
      child: ListView(
          primary: false,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const RegisterFrom(),
            SizedBox(height: defaultSize),
            const AuthScreenRowText(
              mass: 'Already have an account?',
              buttomText: ' Login.',
            ),
          ]),
    );
  }
}
