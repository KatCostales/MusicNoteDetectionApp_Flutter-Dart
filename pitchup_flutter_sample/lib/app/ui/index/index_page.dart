/// [def]

import 'package:flutter/material.dart';
import 'package:pitchupfluttersample/app/ui/pages/uesr_profile.dart';
import 'package:provider/provider.dart';

/// [loc]
import 'package:pitchupfluttersample/app/presenter/index_page_provider.dart';
import 'package:pitchupfluttersample/app/ui/pages/about_view.dart';
import 'package:pitchupfluttersample/app/ui/pages/home_view.dart';
import 'package:pitchupfluttersample/app/ui/pages/contact_view.dart';
import 'package:pitchupfluttersample/app/ui/pages/solutions_view.dart';
import 'package:pitchupfluttersample/app/ui/pages/tools_view.dart';

import 'widgets/side_menu_widget.dart';
import 'widgets/topbar_widget.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({
    Key? key,
    required this.page,
  }) : super(key: key);

  final String page;

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    
    final indexPageProvider = context.read<IndexPageProvider>();

    return Scaffold(
      appBar: const TopbarWidget(),
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: SideMenuWidget(),
      ),
      endDrawerEnableOpenDragGesture: false,
      body: PageView(
        controller: indexPageProvider.controller,
        scrollDirection:
            Axis.vertical,
        children: [
          UserProfile(),
          FlashcardPage(),
          HomeView(),
          AboutView(),
          ContactView(),
          
        ],
      ),
    );
  }
}
