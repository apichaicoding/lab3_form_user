import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:lab3_form_user/main.dart';
import 'package:lab3_form_user/model/model.dart';
import 'package:lab3_form_user/page/home_page.dart';
import 'package:lab3_form_user/redux/actions.dart';
import 'package:redux/redux.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: (Store<AppState> store) => _ViewModel.create(store),
      builder: (BuildContext context, _ViewModel viewModel) => Column(
        children: <Widget>[
          AddItemWidget(viewModel),
        ],
      ),
    );
  }
}

class AddItemWidget extends StatefulWidget {
  final _ViewModel model;

  AddItemWidget(this.model, {super.key});

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItemWidget> {
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController address1 = TextEditingController();
  final TextEditingController address2 = TextEditingController();
  final TextEditingController address3 = TextEditingController();
  final TextEditingController tel = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    controller: firstname,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.45,
                  child: TextFormField(
                    controller: lastname,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    textInputAction: TextInputAction.next,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: address1,
              decoration: InputDecoration(
                hintText: 'Address1',
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: address2,
              decoration: InputDecoration(
                hintText: 'Address2',
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: address3,
              decoration: InputDecoration(
                hintText: 'Address3',
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: tel,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: 'Tel.',
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: firstname.text.isNotEmpty &&
                      lastname.text.isNotEmpty &&
                      address1.text.isNotEmpty &&
                      tel.text.isNotEmpty
                  ? () {
                      widget.model.onAddItem(
                          '${firstname.text} ${lastname.text}',
                          address1.text,
                          address2.text,
                          address3.text,
                          tel.text);
                      tel.text = '';
                      firstname.text = '';
                      lastname.text = '';
                      address1.text = '';
                      address2.text = '';
                      address3.text = '';
                      tel.text = '';
                      FocusScope.of(context).unfocus();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage(
                                  body: HomePage(),
                                  title: "Lab3 Form User",
                                )),
                      );
                    }
                  : null,
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewModel {
  final List<Item> items;
  final Function(String, String, String, String, String) onAddItem;

  _ViewModel({
    required this.items,
    required this.onAddItem,
  });

  factory _ViewModel.create(Store<AppState> store) {
    _onAddItem(String name, String address1, String address2, String address3,
        String tel) {
      store.dispatch(AddItemAction(name, address1, address2, address3, tel));
    }

    return _ViewModel(
      items: store.state.items,
      onAddItem: _onAddItem,
    );
  }
}
