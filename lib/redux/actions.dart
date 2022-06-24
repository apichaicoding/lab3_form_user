import 'package:lab3_form_user/model/model.dart';

class AddItemAction {
  static int _id = 0;
  final String name;
  final String address1;
  final String address2;
  final String address3;
  final String tel;

  AddItemAction(
    this.name,
    this.address1,
    this.address2,
    this.address3,
    this.tel,
  ) {
    _id += 1;
  }

  int get id => _id;
}

class RemoveItemAction {
  final Item item;

  RemoveItemAction(this.item);
}
