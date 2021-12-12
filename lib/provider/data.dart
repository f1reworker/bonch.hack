import 'package:bonch_hack/classes.dart';
import 'package:flutter/widgets.dart';

int _data = 0;
List<Menu> data2 = [];
List<Menu> nowOrderData = cart;

class ChangeSumm with ChangeNotifier {
  List<Menu> get getNowOrderData => nowOrderData;
  int get getData => _data;
  List<Menu> get getData2 => data2;
  void getList(menu) {
    data2 = menu;
    notifyListeners();
  }

  void changeSumm(List<Menu> cart) {
    summOrder = 0;
    for (int i = 0; i < cart.length; i++) {
      summOrder += cart[i].price * cart[i].count;
    }
    _data = summOrder;
    notifyListeners();
  }

  void getNowOrder(nowOrder) {
    nowOrderData = nowOrder;
    notifyListeners();
  }
}
