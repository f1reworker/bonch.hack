class Restaurants {
  String name;
  String type;
  String reseipt;
  String score;
  List<String> photo;
  bool favorite;
  int count;
  bool inCart;
  List<String> menu;

  Restaurants({
    required this.menu,
    required this.inCart,
    required this.count,
    required this.name,
    required this.type,
    required this.reseipt,
    required this.score,
    required this.photo,
    required this.favorite,
  });
}

class Menu {
  String item;
  int price;
  String description;
  String type;
  bool inCart;
  bool open;
  int count;
  Menu(
      {required this.item,
      required this.count,
      required this.inCart,
      required this.open,
      required this.price,
      required this.description,
      required this.type});
}

List<Menu> cart = [];
Set<String> countRest = {};
int summOrder = 0;
Map<String, List<Menu>> lastOrder = {};
List<Menu> nowOrder = [];
String nowRest = "";
