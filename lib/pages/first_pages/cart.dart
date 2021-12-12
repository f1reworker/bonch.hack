import 'package:bonch_hack/main.dart';
import 'package:bonch_hack/pages/first_pages/list_rest.dart';
import 'package:bonch_hack/provider/data.dart';
import 'package:bonch_hack/utils.dart';
import 'package:bonch_hack/classes.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

String dropdownValue = "...";

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  int sumOrder = 0;

  get children => null;
  DateTime dateTo = DateTime.now().add(const Duration(hours: 1));

  void makeOrder(context) {
    String text = "";
    summOrder = 0;
    for (int i = 0; i < cart.length; i++) {
      summOrder += cart[i].price * cart[i].count;
    }
    if (summOrder == 0) {
      text = 'Ваша корзина пуста.';
    } else if (dropdownValue == "...") {
      text = 'Пожалуйста, выберите стол.';
    } else {
      text = 'Оформить заказ?';
    }

    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                content: Text(text),
                actionsAlignment: MainAxisAlignment.end,
                actions: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Отмена")),
                  TextButton(
                      onPressed: () {
                        if (text == 'Оформить заказ?') {
                          String name2 = countRest.toList()[0];
                          if (nowRest != "") {
                            lastOrder.addAll({nowRest: nowOrder});
                          }

                          List<String> keys = menuList[name2]!.keys.toList();

                          nowRest = name2;
                          nowOrder = [];
                          for (int i = 0; i < cart.length; i++) {
                            nowOrder.add(Menu(
                                item: cart[i].item,
                                count: cart[i].count,
                                inCart: cart[i].inCart,
                                open: cart[i].open,
                                price: cart[i].price,
                                description: cart[i].description,
                                type: cart[i].type));
                          }
                          for (int i = 0; i < keys.length; i++) {
                            int len = menuList[name2]![keys[i]]!.length - 1;
                            for (int q = 0; q < len; q++) {
                              menuList[name2]![keys[i]]![q].inCart = false;
                              menuList[name2]![keys[i]]![q].count = 1;
                            }
                          }
                          countRest.clear();
                          cart = [];

                          context.read<ChangeSumm>().getList(cart);
                          context.read<ChangeSumm>().changeSumm(cart);
                        }
                        Navigator.pop(context);
                      },
                      child: const Text("Ok")),
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Корзина"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, children: [
            buildTo(),
            buildHeader(
                header: countRest.toList().isEmpty ? "" : countRest.toList()[0],
                child: const CartItem()),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () => makeOrder(context),
                child: const Summ(),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                ),
              ),
            ),
          ]),
        ));
  }

  Widget buildTo() => buildHeader(
        header: 'Выберите дату и время:',
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: buildDropdownField(
                text: Utils.toDate(dateTo),
                onClicked: () => pickDeadline(pickDate: true),
              ),
            ),
            Expanded(
              child: buildDropdownField(
                text: Utils.toTime(dateTo),
                onClicked: () => pickDeadline(pickDate: false),
              ),
            ),
          ],
        ),
      );
  Future pickDeadline({required bool pickDate}) async {
    final date = await pickDateTime(dateTo, pickDate: pickDate);
    if (date == null || date.isBefore(DateTime.now())) return;

    setState(() => dateTo = date);
  }

  Future<DateTime?> pickDateTime(
    DateTime initialDate, {
    required bool pickDate,
    DateTime? firstDate,
  }) async {
    if (pickDate) {
      final date = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: firstDate ?? DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (date == null) return null;
      final time =
          Duration(hours: initialDate.hour, minutes: initialDate.minute);
      return date.add(time);
    } else {
      final timeOfDay = await showTimePicker(
          context: context, initialTime: TimeOfDay.fromDateTime(initialDate));
      if (timeOfDay == null) return null;
      final date =
          DateTime(initialDate.year, initialDate.month, initialDate.day);
      final time = Duration(hours: timeOfDay.hour, minutes: timeOfDay.minute);
      return date.add(time);
    }
  }

  Widget buildHeader({
    required String header,
    required Widget child,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            header,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          child,
        ],
      );
  Widget buildDropdownField({
    required String text,
    required VoidCallback onClicked,
  }) =>
      ListTile(
        title: Text(text),
        trailing: const Icon(Icons.arrow_drop_down),
        onTap: onClicked,
      );
}

class CountButton extends StatefulWidget {
  const CountButton({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  _CountButtonState createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
  void changeCount(int i) {
    setState(() {
      cart[widget.index].count += i;
      if (cart[widget.index].count < 0) {
        cart[widget.index].count = 0;
        summOrder = 0;
      }
      context.read<ChangeSumm>().changeSumm(cart);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              changeCount(-1);
            },
            child: const Text("-")),
        Text(cart[widget.index].count.toString()),
        TextButton(
            onPressed: () {
              changeCount(1);
            },
            child: const Text("+")),
      ],
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final List<String> _salutations = ['1', '2', '4', '5', '6', '...'];
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        isExpanded: true,
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        //style: const TextStyle(color: Colors.b),
        underline: Container(
          height: 2,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: _salutations
            .map((String item) =>
                DropdownMenuItem<String>(child: Text(item), value: item))
            .toList());
  }
}

class Summ extends StatelessWidget {
  const Summ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        "Сделать заказ  " + context.watch<ChangeSumm>().getData.toString());
  }
}

class CartItem extends StatelessWidget {
  const CartItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return context.watch<ChangeSumm>().getData2.isNotEmpty
        ? Column(
            children: [
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.fromLTRB(9, 10, 6, 10),
                        decoration: BoxDecoration(
                            color: myColor,
                            border: Border.all(
                              color: Colors.green,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: MediaQuery.of(context).size.width - 170,
                                child: ListView(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    children: [
                                      Text(context
                                              .watch<ChangeSumm>()
                                              .getData2[index]
                                              .item +
                                          ":   " +
                                          context
                                              .watch<ChangeSumm>()
                                              .getData2[index]
                                              .price
                                              .toString()),
                                    ])),
                            CountButton(
                              index: index,
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => const Divider(
                        color: Colors.white,
                        height: 9,
                      ),
                  itemCount: context.watch<ChangeSumm>().getData2.length),
              const SizedBox(
                height: 5,
              ),
              _CartState().buildHeader(
                  header: "Выберите стол", child: const DropDown()),
              Image.asset("assets/ylassicheskiy_zal.jpg")
            ],
          )
        : const SizedBox();
  }
}
