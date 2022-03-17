import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core_export.dart';

class CustomRefreshWidget extends StatelessWidget {
  final Widget child;
  const CustomRefreshWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return RefreshIndicator(
          onRefresh: () async {
            refreshContrllors.onRefresh();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              if (refreshContrllors.loading.value)
                SizedBox(
                  height: defaultSize * 5.5,
                  child: const Center(
                    child: CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        kPrimaryColor,
                      ),
                    ),
                  ),
                ),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
