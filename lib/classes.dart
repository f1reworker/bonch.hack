class Restaurants {
  String name;
  String type;
  String reseipt;
  String score;
  List<String> photo;
  bool favorite;
  Map<String, List> menu;

  Restaurants({
    required this.name,
    required this.type,
    required this.reseipt,
    required this.score,
    required this.photo,
    required this.favorite,
    required this.menu,
  });
}

List<Restaurants> cart = [];
