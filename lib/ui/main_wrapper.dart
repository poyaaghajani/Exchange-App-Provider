import 'package:exchange/ui/home_screen.dart';
import 'package:exchange/ui/market_view_screen.dart';
import 'package:exchange/ui/profile_screen.dart';
import 'package:exchange/ui/ui_helper/bottom.nav.dart';
import 'package:exchange/ui/watch_list_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  final PageController _myPage = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          backgroundColor: primaryColor,
          onPressed: () {},
          child: const Icon(Icons.compare_arrows_outlined),
        ),
        bottomNavigationBar: BottomNav(
          controller: _myPage,
        ),
        body: PageView(
          controller: _myPage,
          children: [
            HomeScreen(),
            MarketViewPage(),
            ProfileScreen(),
            WatchListScreen(),
          ],
        ),
      ),
    );
  }
}
