import 'package:flutter/cupertino.dart';
import 'package:test_provider/viewmodel/catalogvm.dart';

class CartModel extends ChangeNotifier {
  //inital empty list
  final List<int> itemsIds = [];

  /// List of items in the cart.
  List<Item> get items => itemsIds.map((id) => catalog.getById(id)).toList();

  /// The current total price of all items.
  int get totalPrice => items.fold(0, (total, current) => total + current.price);

  /// The current catalog. Used to construct items from numeric ids.
  late final CatalogModel _catalog = CatalogModel();
  CatalogModel get catalog => _catalog;

  set catalog(CatalogModel newCatalog) {
    catalog = newCatalog;
    // Notify listeners, in case the new catalog provides information
    // different from the previous one. For example, availability of an item
    // might have changed.
    notifyListeners();
  }

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    itemsIds.add(item.id);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Item item) {
    itemsIds.remove(item.id);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}
