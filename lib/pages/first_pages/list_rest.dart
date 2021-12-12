import 'package:bonch_hack/classes.dart';
import 'package:bonch_hack/main.dart';
import 'package:bonch_hack/pages/page_rest.dart';
import 'package:flutter/material.dart';

class ListRest extends StatelessWidget {
  const ListRest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Список заведений"),
      ),
      body: const BuildListRest(),
    );
  }
}

class BuildListRest extends StatefulWidget {
  const BuildListRest({Key? key}) : super(key: key);

  @override
  _BuildListRestState createState() => _BuildListRestState();
}

class _BuildListRestState extends State<BuildListRest> {
  var controller = TextEditingController();

  bool favorite = false;
  String val = "";
  List<Restaurants> favRest = [];
  List<Restaurants> dubFavRest = [];
  List<Restaurants> dubRest = [];

  @override
  void initState() {
    super.initState();
    val = "";
    favRest.clear();
    for (int i = 0; i < rest.length; i++) {
      if (rest[i].favorite) {
        favRest.add(rest[i]);
        dubFavRest.add(rest[i]);
      }
    }
    dubRest = rest;
  }

  void updateFavorite(bool fav) {
    setState(() {
      favorite = fav;
      if (fav == true) {
        favRest.clear();
        for (int i = 0; i < rest.length; i++) {
          if (rest[i].favorite) {
            favRest.add(rest[i]);
          }
        }
      }
      if (val != "") {
        if (favorite) {
          dubFavRest = [];
          for (int i = 0; i < favRest.length; i++) {
            if (favRest[i].name.toLowerCase().contains(val.toLowerCase()) ||
                favRest[i].type.toLowerCase().contains(val.toLowerCase())) {
              dubFavRest.add(favRest[i]);
            }
          }
        } else {
          dubRest = [];
          for (int i = 0; i < rest.length; i++) {
            if (rest[i].name.toLowerCase().contains(val) ||
                rest[i].type.toLowerCase().contains(val)) {
              dubRest.add(rest[i]);
            }
          }
        }
      } else {
        dubRest = rest;
        dubFavRest = favRest;
      }
    });
  }

  void search(value) {
    setState(() {
      val = value;
      if (val != "") {
        if (favorite) {
          dubFavRest = [];
          for (int i = 0; i < favRest.length; i++) {
            if (favRest[i].name.toLowerCase().contains(value.toLowerCase()) ||
                favRest[i].type.toLowerCase().contains(value.toLowerCase())) {
              dubFavRest.add(favRest[i]);
            }
          }
        } else {
          dubRest = [];
          for (int i = 0; i < rest.length; i++) {
            if (rest[i].name.toLowerCase().contains(value) ||
                rest[i].type.toLowerCase().contains(value)) {
              dubRest.add(rest[i]);
            }
          }
        }
      } else {
        dubRest = rest;
        dubFavRest = favRest;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    controller.text = val;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateFavorite(false);
                  },
                  child: const SizedBox(
                      width: 120, child: Center(child: Text("Все заведения"))),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateFavorite(true);
                  },
                  child: const SizedBox(
                      width: 120, child: Center(child: Text("Избранное"))),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            height: 50,
            child: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: myColor,
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 20),
                  hintText: 'Поиск кафе, ресторанов...',
                  hintStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.green),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(width: 2, color: Colors.green),
                    borderRadius: BorderRadius.circular(25),
                  )),
              onChanged: (value) => search(value),
            ),
          ),
          favorite
              ? BuildistSeparated(rest: dubFavRest)
              : BuildistSeparated(rest: dubRest),
        ],
      ),
    );
  }
}

class BuildistSeparated extends StatefulWidget {
  const BuildistSeparated({Key? key, required this.rest}) : super(key: key);
  final List<Restaurants> rest;

  @override
  _BuildistSeparatedState createState() => _BuildistSeparatedState();
}

class _BuildistSeparatedState extends State<BuildistSeparated> {
  void addFavourite(index) {
    setState(() {
      widget.rest[index].favorite = !widget.rest[index].favorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) => TextButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green.shade100),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.green, width: 2),
                  ))),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PageRest(info: widget.rest[index])));
              },
              child: Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(widget.rest[index].photo[0]),
                      radius: 50,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.rest[index].name,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 18),
                        ),
                        Text(
                          "Тип заведения: " + widget.rest[index].type,
                          style: const TextStyle(color: Colors.black87),
                        ),
                        Text(
                          "Цены: " + widget.rest[index].reseipt,
                          style: const TextStyle(color: Colors.red),
                        ),
                        Text(
                          "Средняя оценка: " + widget.rest[index].score,
                          style: TextStyle(color: Colors.greenAccent.shade700),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                          onPressed: () {
                            addFavourite(index);
                          },
                          icon: widget.rest[index].favorite
                              ? const Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : const Icon(Icons.favorite_border)))
                ],
              ),
            ),
        separatorBuilder: (context, index) => const Divider(
              color: Colors.white,
              height: 7,
            ),
        itemCount: widget.rest.length);
  }
}

List<Restaurants> restLove = [];
List<Restaurants> rest = [
  Restaurants(
    menu: ["Завтраки", "Закуски"],
    inCart: false,
    count: 0,
    //loc: const LatLng(59.943854, 30.350840),
    name: "Birch",
    type: "Ресторан",
    reseipt: "₽₽₽₽",
    score: "4,9",
    favorite: false,
    photo: [
      "assets/large_й1.jpg",
      "https://avatars.mds.yandex.net/get-altay/1666174/2a0000016b8c6a5d305841d5c63d92fc272b/XXL"
    ],
  ),
  Restaurants(
    menu: ["Завтраки", "Закуски"],
    inCart: false,
    count: 0,
    //loc: const LatLng(59.933816, 30.322417),
    favorite: false,
    name: "Terrassa",
    type: "Ресторан",
    reseipt: "₽₽₽₽",
    score: "4,6",
    photo: [
      "assets/2.jpg",
      "https://avatars.mds.yandex.net/get-altay/200322/2a0000015b2eaed16dea4481355f5a7248a0/XXXL"
    ],
  ),
  Restaurants(
    menu: ["Завтраки", "Закуски"],
    inCart: false,
    count: 0,
    //loc: const LatLng(30.311953, 59.948079),
    favorite: false,
    name: "Корюшка",
    type: "Ресторан",
    reseipt: "₽₽₽₽",
    score: "4,9",
    photo: [
      "assets/3.jpg",
      "https://banketservice.ru/images/katalog/restoran/korushka/korushka_00009.jpg"
    ],
  ),
  Restaurants(
    menu: ["Завтраки", "Закуски"],
    inCart: false,
    count: 0,
    //loc: const LatLng(59.935840, 30.325875),
    favorite: false,
    name: "ЗингерЪ",
    type: "Кафе",
    reseipt: "₽₽₽₽",
    score: "4,7",
    photo: [
      "assets/4.jpg",
      "http://s0.dibi.ru/sankt-peterburg/pic_800_600/26844997/97183cf040e060e09925175cadef0d87.jpg"
    ],
  ),
  Restaurants(
    menu: ["Завтраки", "Закуски"],
    inCart: false,
    count: 0,
    //loc: const LatLng(59.936796, 30.342782),
    favorite: false,
    name: "Мечтатели",
    type: "Кафе",
    reseipt: "₽₽₽₽",
    score: "4,6",
    photo: ["assets/5.png", "https://fb.ru/misc/i/gallery/47201/2963568.jpg"],
  ),
];

Map<String, Map<String, List<dynamic>>> menuList = {
  "Birch": {
    "Завтраки": [
      Menu(
          count: 1,
          description: "Рикотта, яйца, сметана, соленая карамель, клюква",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 590,
          item: "Сырники с соленой карамелью и сметаной 330 г"),
      Menu(
          count: 1,
          description:
              "Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ],
    "Закуски": [
      Menu(
          count: 1,
          description:
              "Мука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Пирог с уткой, сметанным соусом и клюквой 115 г"),
      Menu(
          count: 1,
          description:
              "Паштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ]
  },
  "Terrassa": {
    "Завтраки": [
      Menu(
          count: 1,
          description: "Рикотта, яйца, сметана, соленая карамель, клюква",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 590,
          item: "Сырники с соленой карамелью и сметаной 330 г"),
      Menu(
          count: 1,
          description:
              "Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ],
    "Закуски": [
      Menu(
          count: 1,
          description:
              "Мука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Пирог с уткой, сметанным соусом и клюквой 115 г"),
      Menu(
          count: 1,
          description:
              "Паштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ]
  },
  "ЗингерЪ": {
    "Завтраки": [
      Menu(
          count: 1,
          description: "Рикотта, яйца, сметана, соленая карамель, клюква",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 590,
          item: "Сырники с соленой карамелью и сметаной 330 г"),
      Menu(
          count: 1,
          description:
              "Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ],
    "Закуски": [
      Menu(
          count: 1,
          description:
              "Мука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Пирог с уткой, сметанным соусом и клюквой 115 г"),
      Menu(
          count: 1,
          description:
              "Паштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ]
  },
  "Корюшка": {
    "Завтраки": [
      Menu(
          count: 1,
          description: "Рикотта, яйца, сметана, соленая карамель, клюква",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 590,
          item: "Сырники с соленой карамелью и сметаной 330 г"),
      Menu(
          count: 1,
          description:
              "Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ],
    "Закуски": [
      Menu(
          count: 1,
          description:
              "Мука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Пирог с уткой, сметанным соусом и клюквой 115 г"),
      Menu(
          count: 1,
          description:
              "Паштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ]
  },
  "Мечтатели": {
    "Завтраки": [
      Menu(
          count: 1,
          description: "Рикотта, яйца, сметана, соленая карамель, клюква",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 590,
          item: "Сырники с соленой карамелью и сметаной 330 г"),
      Menu(
          count: 1,
          description:
              "Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          type: "Завтраки",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ],
    "Закуски": [
      Menu(
          count: 1,
          description:
              "Мука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Пирог с уткой, сметанным соусом и клюквой 115 г"),
      Menu(
          count: 1,
          description:
              "Паштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          type: "Закуски",
          inCart: false,
          open: false,
          price: 620,
          item: "Сырники с кокосовой сгущенкой и черникой 330 г"),
      false,
    ]
  }
};
