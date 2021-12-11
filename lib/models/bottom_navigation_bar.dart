import 'package:bonch_hack/pages/first_pages/history.dart';
import 'package:bonch_hack/pages/first_pages/list_rest.dart';
import 'package:bonch_hack/pages/first_pages/cart.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final int inIndex;
  const NavigationBar({Key? key, required this.inIndex}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: inIndex,
      child: const Scaffold(
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [ListRest(), Cart(), History()],
        ),
        bottomNavigationBar: TabBar(
          tabs: [
            Tab(
              icon: Icon(
                Icons.search,
                size: 27,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.shopping_cart_outlined,
                size: 27,
                color: Colors.white,
              ),
            ),
            Tab(
              icon: Icon(
                Icons.history,
                size: 27,
                color: Colors.white,
              ),
            ),
          ],
        ),
        primary: true,
        backgroundColor: Colors.blue,
      ),
    );
  }
}
