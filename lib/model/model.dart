class Item {
  final int id;
  final String name;
  final String address1;
  final String address2;
  final String address3;
  final String tel;

  Item({
    required this.id,
    required this.name,
    required this.address1,
    required this.address2,
    required this.address3,
    required this.tel,
  });

  Item copyWith(
      {required int id,
      required String name,
      required String address1,
      required String address2,
      required String address3,
      required String tel}) {
    return Item(
      id: id + 1,
      name: name,
      address1: address1,
      address2: address2,
      address3: address3,
      tel: tel,
    );
  }
}

class AppState {
  final List<Item> items;

  AppState({
    required this.items,
  });

  AppState.initialState() : items = List.unmodifiable(<Item>[]);
}
