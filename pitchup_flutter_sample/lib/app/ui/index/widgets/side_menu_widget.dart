import 'package:argo/argo.dart';
import 'package:pitchupfluttersample/app/presenter/index_page_provider.dart';
import 'package:pitchupfluttersample/app/ui/core/header_item_uim.dart';
import 'package:pitchupfluttersample/app/ui/shared/top_menu/points_decoration_widget.dart';
import 'package:pitchupfluttersample/config/values/values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'menu_item_widget.dart';

class SideMenuWidget extends StatelessWidget {
  const SideMenuWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sideMenuItems = context
        .select<IndexPageProvider, List<HeaderItemUIModel>>((it) => it.items);

    return Container(
      padding: EdgeInsets.only(top: PlatformInfo.isWeb ? kSpaceMedium : 0),
      height: context.heightPx,
      color: kBgLightColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: kSpaceMedium),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.center,
                child: PointsDecorationWidget(
                  radius: 10,
                  colors: [
                    Colors.lightGreen,
                    kCreamColor,
                    kCreamColor,
                     Colors.lightGreen,
                  ],
                ),
              ),
              kSpaceBigVertical,
              ...sideMenuItems
                  .map((item) => SideMenuItemWidget(
                        item: item,
                        showBorder: sideMenuItems.last.id != item.id,
                      ))
                  .toList(),

              // Tags
            ],
          ),
        ),
      ),
    );
  }
}
