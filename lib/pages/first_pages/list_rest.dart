import 'package:bonch_hack/classes.dart';
import 'package:bonch_hack/pages/page_rest.dart';
import 'package:flutter/material.dart';

class ListRest extends StatelessWidget {
  const ListRest({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("List"),
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
  bool favorite = false;
  List<Restaurants> favRest = [];

  @override
  void initState() {
    super.initState();
    favRest.clear();
    for (int i = 0; i < rest.length; i++) {
      if (rest[i].favorite) {
        favRest.add(rest[i]);
      }
    }
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        //physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                ElevatedButton(
                  onPressed: () {
                    updateFavorite(false);
                  },
                  child: const Text("Все рестораны"),
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
                  child: const Text("Любимые рестораны"),
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
          TextFormField(
            controller: TextEditingController(),
          ),
          favorite
              ? BuildistSeparated(rest: favRest)
              : BuildistSeparated(rest: rest),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            PageRest(info: widget.rest[index])));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: 80,
                      width: 100,
                      child: Image.network(widget.rest[index].photo[0])),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.rest[index].name),
                        Text(widget.rest[index].type),
                        Text(widget.rest[index].reseipt),
                        Text(widget.rest[index].score),
                      ],
                    ),
                  ),
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
              color: Colors.grey,
              height: 2,
            ),
        itemCount: widget.rest.length);
  }
}

List<Restaurants> restLove = [];
List<Restaurants> rest = [
  Restaurants(
      //loc: const LatLng(59.943854, 30.350840),
      name: "Birch",
      type: "Ресторан",
      reseipt: "₽₽₽₽",
      score: "4,9",
      favorite: true,
      photo: [
        "https://a-a-ah-ru.s3.amazonaws.com/uploads/items/150876/311659/large_%D0%B91.jpg",
        "https://avatars.mds.yandex.net/get-altay/1666174/2a0000016b8c6a5d305841d5c63d92fc272b/XXL"
      ],
      menu: {
        "Завтраки": [
          "Сырники с соленой карамелью и сметаной 330 г:   590₽ \n\n Рикотта, яйца, сметана, соленая карамель, клюква",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ],
        "Закуски": [
          "Пирог с уткой, сметанным соусом и клюквой 115 г:    620₽\n\nМука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          "Паштет из куриной печени с гранатовой карамелью и пеканом 200г:    620₽\n\nПаштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ]
      }),
  Restaurants(
      //loc: const LatLng(59.933816, 30.322417),
      favorite: false,
      name: "Terrassa",
      type: "Ресторан",
      reseipt: "₽₽₽₽",
      score: "4,6",
      photo: [
        "https://avia-all.ru/uploads/posts/2020-07/1595027332_dbd2b2c10571d057539004b9b6366b08.jpg",
        "https://avatars.mds.yandex.net/get-altay/200322/2a0000015b2eaed16dea4481355f5a7248a0/XXXL"
      ],
      menu: {
        "Завтраки": [
          "Сырники с соленой карамелью и сметаной 330 г:   590₽ \n\n Рикотта, яйца, сметана, соленая карамель, клюква",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ],
        "Закуски": [
          "Пирог с уткой, сметанным соусом и клюквой 115 г:    620₽\n\nМука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          "Паштет из куриной печени с гранатовой карамелью и пеканом 200г:    620₽\n\nПаштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          false
        ]
      }),
  Restaurants(
      //loc: const LatLng(30.311953, 59.948079),
      favorite: false,
      name: "Корюшка",
      type: "Ресторан",
      reseipt: "₽₽₽₽",
      score: "4,9",
      photo: [
        "https://1000prichin.ru/images/KATALOG/sankt-peterburg/Restorani/korushka/korushka_10.jpg",
        "https://banketservice.ru/images/katalog/restoran/korushka/korushka_00009.jpg"
      ],
      menu: {
        "Завтраки": [
          "Сырники с соленой карамелью и сметаной 330 г:   590₽ \n\n Рикотта, яйца, сметана, соленая карамель, клюква",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ],
        "Закуски": [
          "Пирог с уткой, сметанным соусом и клюквой 115 г:    620₽\n\nМука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          "Паштет из куриной печени с гранатовой карамелью и пеканом 200г:    620₽\n\nПаштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          false
        ]
      }),
  Restaurants(
      //loc: const LatLng(59.935840, 30.325875),
      favorite: false,
      name: "ЗингерЪ",
      type: "Кафе",
      reseipt: "₽₽₽₽",
      score: "4,7",
      photo: [
        "https://avatars.mds.yandex.net/get-altay/2838749/2a00000173d88de7098a450da0e2a2a53854/XXL",
        "http://s0.dibi.ru/sankt-peterburg/pic_800_600/26844997/97183cf040e060e09925175cadef0d87.jpg"
      ],
      menu: {
        "Завтраки": [
          "Сырники с соленой карамелью и сметаной 330 г:   590₽ \n\n Рикотта, яйца, сметана, соленая карамель, клюква",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ],
        "Закуски": [
          "Пирог с уткой, сметанным соусом и клюквой 115 г:    620₽\n\nМука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          "Паштет из куриной печени с гранатовой карамелью и пеканом 200г:    620₽\n\nПаштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          false
        ]
      }),
  Restaurants(
      //loc: const LatLng(59.936796, 30.342782),
      favorite: false,
      name: "Мечтатели",
      type: "Кафе",
      reseipt: "₽₽₽₽",
      score: "4,6",
      photo: [
        "https://i.timeout.ru/pix/526542.jpeg",
        "https://fb.ru/misc/i/gallery/47201/2963568.jpg"
      ],
      menu: {
        "Завтраки": [
          "Сырники с соленой карамелью и сметаной 330 г:   590₽ \n\n Рикотта, яйца, сметана, соленая карамель, клюква",
          "Сырники с кокосовой сгущенкой и черникой 330 г:   620₽ \n\n Рикотта, яйца, сметана, кокос, кокосовые сливки, черника, негрони",
          false
        ],
        "Закуски": [
          "Пирог с уткой, сметанным соусом и клюквой 115 г:    620₽\n\nМука, сливочное масло, молоко, яйца, сахар, утка, соус терияки, сметана, клюква",
          "Паштет из куриной печени с гранатовой карамелью и пеканом 200г:    620₽\n\nПаштет из куриной печени, гранатовая карамель, желе из граната, орех пекан",
          false
        ]
      }),
];
