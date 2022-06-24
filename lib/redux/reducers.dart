import 'package:lab3_form_user/model/model.dart';
import 'package:lab3_form_user/redux/actions.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
    items: itemReducer(state.items, action),
  );
}

List<Item> itemReducer(List<Item> state, action) {
  if (action is AddItemAction) {
    return []
      ..addAll(state)
      ..add(Item(
          id: action.id,
          name: action.name,
          address1: action.address1,
          address2: action.address2,
          address3: action.address3,
          tel: action.tel));
  }

  if (action is RemoveItemAction) {
    return List.unmodifiable(List.from(state)..remove(action.item));
  }

  return state;
}
