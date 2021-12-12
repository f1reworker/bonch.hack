import 'package:bonch_hack/classes.dart';
import 'package:bonch_hack/models/bottom_navigation.dart';
import 'package:bonch_hack/pages/first_pages/list_rest.dart';
import 'package:bonch_hack/provider/data.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

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
        )
      ],
    );
  }
}

class BuildMenu extends StatefulWidget {
  const BuildMenu({Key? key, required this.info}) : super(key: key);
  final Restaurants info;
  @override
  _BuildMenuState createState() => _BuildMenuState();
}

class _BuildMenuState extends State<BuildMenu> {
  void openElement(index) {
    setState(() {
      menuList[widget.info.name]![index]!.last =
          !menuList[widget.info.name]![index]!.last;
    });
  }

  void addToCart(name, String type, index) {
    countRest.add(name);

    if (countRest.length > 1) {
      showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                content: const Text(
                    "У вас уже есть товары из других заведений. Удалить их из корзины?"),
                actionsAlignment: MainAxisAlignment.end,
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        String name2 = countRest.toList()[0];
                        List<String> keys = menuList[name2]!.keys.toList();
                        for (int i = 0; i < keys.length; i++) {
                          int len = menuList[name2]![keys[i]]!.length - 1;
                          for (int q = 0; q < len; q++) {
                            menuList[name2]![keys[i]]![q].inCart = false;
                          }
                        }
                        cart.clear();
                        countRest.clear();
                        Navigator.pop(context, 'Да');
                        if (menuList[name]![type]![index].inCart == false) {
                          cart.add(menuList[name]![type]![index]);
                          menuList[name]![type]![index].inCart = true;
                          countRest.add(name);
                          context.read<ChangeSumm>().getList(cart);
                          context.read<ChangeSumm>().changeSumm(cart);
                        }
                      },
                      child: const Text('Да')),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Нет');
                        return;
                      },
                      child: const Text('Нет')),
                ],
              ));
    } else {
      if (menuList[name]![type]![index].inCart == false) {
        cart.add(Menu(
            item: menuList[name]![type]![index].item,
            count: menuList[name]![type]![index].count,
            inCart: menuList[name]![type]![index].inCart,
            open: menuList[name]![type]![index].open,
            price: menuList[name]![type]![index].price,
            description: menuList[name]![type]![index].description,
            type: menuList[name]![type]![index].type));
        menuList[name]![type]![index].inCart = true;
        countRest.add(name);
        context.read<ChangeSumm>().changeSumm(cart);
        context.read<ChangeSumm>().getList(cart);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => TextButton(
              onPressed: () {
                openElement(widget.info.menu[index]);
              },
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Row(children: [
                    menuList[widget.info.name]![widget.info.menu[index]]!
                                .last ==
                            false
                        ? Icon(Icons.chevron_right_sharp)
                        : Icon(Icons.keyboard_arrow_down_sharp),
                    Text(widget.info.menu[index])
                  ]),
                  // ignore: unrelated_type_equality_checks
                  menuList[widget.info.name]![widget.info.menu[index]]!.last ==
                          true
                      ? ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, ind) => Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  margin: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.green,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: ListView(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: [
                                                Text((menuList[
                                                            widget.info
                                                                .name]![widget
                                                            .info
                                                            .menu[index]]![ind]
                                                        .item +
                                                    ":   " +
                                                    menuList[widget.info.name]![
                                                            widget.info.menu[
                                                                index]]![ind]
                                                        .price
                                                        .toString() +
                                                    "P")),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                    menuList[widget.info.name]![
                                                            widget.info.menu[
                                                                index]]![ind]
                                                        .description)
                                              ])),
                                      IconButton(
                                          onPressed: () {
                                            String name = widget.info.name;
                                            String type =
                                                widget.info.menu[index];
                                            addToCart(name, type, ind);
                                          },
                                          icon: const Icon(
                                              Icons.add_shopping_cart_outlined))
                                    ],
                                  ),
                                ),
                              ),
                          separatorBuilder: (context, index) => const Divider(
                                color: Colors.grey,
                                height: 2,
                              ),
                          itemCount: menuList[widget.info.name]![
                                      widget.info.menu[index]]!
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
        itemCount: menuList[widget.info.name]!.length);
  }
}
