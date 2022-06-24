import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lab3_form_user/main.dart';
import 'package:lab3_form_user/model/model.dart';
import 'package:lab3_form_user/redux/actions.dart';
import 'package:redux/redux.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) => Column(
        children: <Widget>[
          Expanded(child: ItemListWidget(viewModel)),
        ],
      ),
    );
  }
}

class ItemListWidget extends StatefulWidget {
  final _ViewModel model;

  ItemListWidget(this.model, {super.key});

  @override
  State<ItemListWidget> createState() => _ItemListWidgetState();
}

class _ItemListWidgetState extends State<ItemListWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: widget.model.items
          .map((Item item) => Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.6,
                height: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 8.5,
                        blurStyle: BlurStyle.outer,
                        offset: Offset(1, -1),
                      )
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      item.id.toString(),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Name:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(item.name),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tel.:",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(item.tel),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                            onPressed: () => widget.model.onRemoveItem(item),
                            child: Text("Delete")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItemLitWidget(
                                            item.name,
                                            item.address1,
                                            item.address2,
                                            item.address3,
                                            item.tel,
                                          )),
                                );
                              });
                            },
                            child: Text("Detail")),
                      ],
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}

class ItemLitWidget extends StatelessWidget {
  final String name;
  final String address1;
  final String address2;
  final String address3;
  final String tel;
  ItemLitWidget(
      this.name, this.address1, this.address2, this.address3, this.tel,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return MainPage(
      title: "Detail User",
      body: Container(
        padding: EdgeInsets.all(30),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Name:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  name,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address 1:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  address1,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address 2:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  address2,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Address 3:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  address3,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "TTelephone:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  tel,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MainPage(
                              body: HomePage(),
                              title: "Lab3 Form User",
                            )),
                  );
                },
                child: Text("Back")),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final Function(Item) onRemoveItem;

  _ViewModel({
    required this.items,
    required this.onRemoveItem,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onRemoveItem(Item item) {
      store.dispatch(RemoveItemAction(item));
    }

    return _ViewModel(
      items: store.state.items,
      onRemoveItem: _onRemoveItem,
    );
  }
}
