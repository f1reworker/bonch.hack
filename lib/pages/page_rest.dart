import 'package:bonch_hack/classes.dart';
import 'package:bonch_hack/models/bottom_navigation.dart';
import 'package:flutter/material.dart';

class PageRest extends StatefulWidget {
  const PageRest({Key? key, required this.info}) : super(key: key);

  final Restaurants info;

  @override
  _PageRestState createState() => _PageRestState();
}

class _PageRestState extends State<PageRest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    widget.info.favorite = !widget.info.favorite;
                  });
                },
                icon: widget.info.favorite
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(
                        Icons.favorite_border,
                      )),
          ],
          title: Text(widget.info.name),
        ),
        bottomNavigationBar: const BottomBar(),
        body: BodyPageRest(info: widget.info));
  }
}

class BodyPageRest extends StatefulWidget {
  const BodyPageRest({Key? key, required this.info}) : super(key: key);
  final Restaurants info;

  @override
  _BodyPageRestState createState() => _BodyPageRestState();
}

class _BodyPageRestState extends State<BodyPageRest> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Image.network(widget.info.photo[0]),
        BuildMenu(
          info: widget.info,
          menu: widget.info.menu,
        )
      ],
    );
  }
}

class BuildMenu extends StatefulWidget {
  const BuildMenu({Key? key, required this.menu, required this.info})
      : super(key: key);
  final Restaurants info;
  final Map<String, List> menu;
  @override
  _BuildMenuState createState() => _BuildMenuState();
}

class _BuildMenuState extends State<BuildMenu> {
  void openElement(keyEl) {
    setState(() {
      widget.menu[keyEl]!.last = !widget.menu[keyEl]!.last;
    });
  }

  void addToCart(index, ind) {
    cart.add(Restaurants(
        //loc: widget.info.loc,
        name: widget.info.name,
        type: widget.info.type,
        reseipt: widget.info.reseipt,
        score: widget.info.score,
        photo: widget.info.photo,
        favorite: widget.info.favorite,
        menu: {
          widget.menu.keys.toList()[index]: [
            widget.menu[widget.menu.keys.toList()[index]]![ind]!
          ]
        }));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => TextButton(
              onPressed: () {
                openElement(widget.menu.keys.toList()[index]);
              },
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Text(widget.menu.keys.toList()[index]),
                  widget.menu[widget.menu.keys.toList()[index]]!.last
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, ind) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width -
                                                80,
                                        child: ListView(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            children: [
                                              Text(widget.menu[widget.menu.keys
                                                  .toList()[index]]![ind]!),
                                            ])),
                                    IconButton(
                                        onPressed: () {
                                          addToCart(index, ind);
                                        },
                                        icon: const Icon(
                                            Icons.add_shopping_cart_outlined))
                                  ],
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.grey,
                                height: 2,
                              ),
                          itemCount: widget
                                  .menu[widget.menu.keys.toList()[index]]!
                                  .length -
                              1)
                      : const SizedBox()
                ],
              ),
            ),
        separatorBuilder: (context, index) => const Divider(
              color: Colors.grey,
              height: 2,
            ),
        itemCount: widget.menu.length);
  }
}
