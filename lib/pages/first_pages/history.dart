import 'package:bonch_hack/classes.dart';
import 'package:bonch_hack/main.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int summ = 0;
    for (int i = 0; i < nowOrder.length; i++) {
      summ += nowOrder[i].price * nowOrder[i].count;
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("История заказов"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            buildHeader(
                header: "Ваш текущий заказ:",
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: buildHeader(
                      header: nowRest,
                      child: ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Container(
                                margin: const EdgeInsets.only(right: 5),
                                padding:
                                    const EdgeInsets.fromLTRB(9, 10, 9, 10),
                                decoration: BoxDecoration(
                                    color: myColor,
                                    border: Border.all(
                                      color: Colors.green,
                                    ),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(nowOrder[index].item +
                                      "\nКоличество:   " +
                                      nowOrder[index].count.toString() +
                                      "\nСтоимость:   " +
                                      nowOrder[index].price.toString() +
                                      " P"),
                                ),
                              ),
                          separatorBuilder: (context, ind) => const Divider(
                                color: Colors.white,
                                height: 9,
                              ),
                          itemCount: nowOrder.length)),
                )),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Container(
                margin: const EdgeInsets.only(right: 5),
                padding: const EdgeInsets.fromLTRB(9, 10, 9, 10),
                decoration: BoxDecoration(
                    color: Colors.pink.shade200,
                    border: Border.all(
                      color: Colors.green,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Общая сумма:"), Text(summ.toString())],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(6, 0, 4, 0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              content: const Text(
                                  "Официант получил уведомление и скоро к вам подойдет."),
                              actionsAlignment: MainAxisAlignment.end,
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Ok")),
                              ]));
                },
                child: const Text("Вызвать официанта"),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                ),
              ),
            ),
            buildHeader(
                header: "Ваши прошлые заказы:",
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, ind) => Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: buildHeader(
                                header: lastOrder.keys.toList()[index],
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding:
                                        const EdgeInsets.fromLTRB(9, 10, 3, 10),
                                    decoration: BoxDecoration(
                                        color: myColor,
                                        border: Border.all(
                                          color: Colors.green,
                                        ),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20))),
                                    child: Text(lastOrder[lastOrder.keys
                                                .toList()[index]]![ind]
                                            .item +
                                        "\nКоличество:    " +
                                        lastOrder[lastOrder.keys
                                                .toList()[index]]![ind]
                                            .count
                                            .toString() +
                                        "\nСтоимость:   " +
                                        (lastOrder[lastOrder.keys
                                                        .toList()[index]]![ind]
                                                    .count *
                                                lastOrder[lastOrder.keys
                                                        .toList()[index]]![ind]
                                                    .price)
                                            .toString() +
                                        " P"),
                                  ),
                                ),
                              ),
                            ),
                        separatorBuilder: (context, ind) => const Divider(
                              color: Colors.white,
                              height: 9,
                            ),
                        itemCount:
                            lastOrder[lastOrder.keys.toList()[index]]!.length),
                    separatorBuilder: (context, index) => const Divider(
                          color: Colors.grey,
                          height: 2,
                        ),
                    itemCount: lastOrder.length))
          ],
        ),
      ),
    );
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
