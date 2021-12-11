import 'package:bonch_hack/models/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Row(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                child: const Icon(
                  Icons.search,
                  size: 27,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, a1, a2) => const NavigationBar(
                                inIndex: 0,
                              )));
                },
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                child: const Icon(
                  Icons.shopping_cart_outlined,
                  size: 27,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, a1, a2) => const NavigationBar(
                                inIndex: 1,
                              )));
                },
              )),
          SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextButton(
                child: const Icon(
                  Icons.history,
                  size: 27,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, a1, a2) => const NavigationBar(
                                inIndex: 2,
                              )));
                },
              )),
        ],
      ),
    );
  }
}
