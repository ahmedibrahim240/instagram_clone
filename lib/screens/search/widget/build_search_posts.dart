import 'package:flutter/material.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../screens_export.dart';

class BuildSearchPosts extends StatelessWidget {
  const BuildSearchPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 3,
      itemCount: 20,
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) => CustomCachedNetworkImage(
        context: context,
        url: authControllers.getcurrentUser.image,
      ),
      staggeredTileBuilder: (index) => StaggeredTile.count(
          (index % 7 == 0) ? 2 : 1, (index % 7 == 0) ? 2 : 1),
      mainAxisSpacing: 1.3,
      crossAxisSpacing: 1.3,
    );
  }
}
