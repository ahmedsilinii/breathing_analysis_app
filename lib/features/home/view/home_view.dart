import 'package:breathing_analysis_app/constants/constants.dart';
import 'package:breathing_analysis_app/theme/palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeView extends StatefulWidget {
  static Route<dynamic> route() {
    return MaterialPageRoute(builder: (context) => const HomeView());
  }

  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  final appBar = UIConstants.appBar();

  void onPageChange(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: IndexedStack(index: _page, children: UIConstants.bottomTabBarPages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Palette.blueColor,
        child: const Icon(Icons.add, color: Palette.whiteColor,),
      ),
      bottomNavigationBar: CupertinoTabBar(
        currentIndex: _page,
        onTap: onPageChange,
        backgroundColor: Palette.backgroundColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              _page == 0
                  ? AssetsConstants.homeFilledIcon
                  : AssetsConstants.homeOutlinedIcon,
              // ignore: deprecated_member_use
              color: Palette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AssetsConstants.searchIcon,
              // ignore: deprecated_member_use
              color: Palette.whiteColor,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              _page == 2 ? Icons.person : Icons.person_outlined,
              color: Palette.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
