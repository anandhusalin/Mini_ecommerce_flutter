import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import '../db/db_model.dart';
import '../model/buttomy_model.dart';
import '../service/api_service.dart';

class CommonProvider extends ChangeNotifier {
  var box = GetStorage();
  int _index = 0;
  int get index => _index;
  bool _val = true;
  int _cartTotalCount = 0;
  int get cartTotalCount => _cartTotalCount;

  bool get val => _val;
  bool _val2 = true;
  bool get val2 => _val2;

  bool _isExpanded = false;
  bool get isExpanded => _isExpanded;
  setexpansion(val) {
    _isExpanded = val;
    notifyListeners();
  }

  setChangeSwitch(val) {
    _val = val;
    notifyListeners();
  }

  setChangeSwitch2(val2) {
    _val2 = val2;
    notifyListeners();
  }

  setindex(value) {
    _index = value;
    notifyListeners();
  }

  ButtomyModel? _faqlList;
  ButtomyModel? get faqlList => _faqlList;

  bool _faqloader = true;
  bool get faqloader => _faqloader;

  setFaqLoader(bool val) {
    _faqloader = val;
    notifyListeners();
  }

  Future<ButtomyModel?> getFaqDetails() async {
    try {
      setFaqLoader(true);

      var response = await ApiServices().getData(
          "/api/getbusinessbytimeline-petpooja-timing?business_type=1&page_id=351&user_id=367&offset=0&products_type=all&placeorder_type=all");

      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = jsonDecode(jsonString);
        _faqlList = ButtomyModel.fromJson(jsonMap);

        _faqlList!.data!.forEach((category) {
          var productList = category.products!
              .map((item) => Product(
                    kitchenItemId: item.kitchenItemId,
                    kitchenItemName: item.kitchenItemName,
                    kitchenItemAmount: item.kitchenItemAmount,
                    kitchenItemImage: item.kitchenItemImage,
                    cartCount: 0,
                    itemDiscountPrice: item.itemDiscountPrice,
                  ))
              .toList();

          category.products = productList;
        });
      }
    } catch (e) {
      return _faqlList;
    }
    setFaqLoader(false);

    return _faqlList;
  }

  void storeImageAndName({image, name}) {
    box.write("boximageurl", image);
    box.write("boxName", name);
    notifyListeners();
  }

  //// CART FUNCTIONALITY
  final List<CartItem> _cartListNotifier = [];
  List<CartItem> get cartListNotifier => _cartListNotifier;

  void modifyhiveCartItem(CartItem value, bool isAdd) async {
    final box = await Hive.openBox<CartItem>('cart');

    final index =
        box.values.toList().indexWhere((item) => item.name == value.name);
    final updatedItem = CartItem(
        name: value.name, price: value.price, quantity: value.quantity);
    if (value.quantity >= 1) {
      await box.putAt(index, updatedItem);
    } else {
      await box.deleteAt(index);
      clearCart();
    }
    _cartTotalCount = _cartTotalCount + (isAdd ? 1 : -1);
    notifyListeners();
  }

  void modifyCartItem(CartItem value, bool isAdd) async {
    final box = await Hive.openBox<CartItem>('cart');

    if (isAdd) {
      final index =
          box.values.toList().indexWhere((item) => item.name == value.name);

      if (index != -1) {
        final existingItem = box.getAt(index);
        final updatedQuantity = existingItem!.quantity + value.quantity;

        if (updatedQuantity > 0) {
          final updatedItem = CartItem(
              name: existingItem.name,
              price: existingItem.price,
              quantity: updatedQuantity);
          await box.putAt(index, updatedItem);
          _cartListNotifier.add(updatedItem);
        } else {
          await box.deleteAt(index);
          _cartListNotifier.removeWhere((item) => item.key == existingItem.key);
        }
      } else {
        if (value.quantity > 0) {
          await box.add(value);
          print("add is working..");
          _cartListNotifier.add(value);
        }
      }
    } else {
      final index =
          box.values.toList().indexWhere((item) => item.key == value.key);

      if (index != -1) {
        await box.deleteAt(index);
      }

      _cartListNotifier.removeWhere((item) => item.key == value.key);
    }

    notifyListeners();
  }

  void updateCartCount(String productName, bool isAdd) {
    final data = _faqlList?.data;
    if (data != null) {
      for (final item in data) {
        final products = item.products;

        if (products != null) {
          for (final product in products) {
            if (product.kitchenItemName == productName) {
              final currentCount = product.cartCount ?? 0;
              final newCount = currentCount + (isAdd ? 1 : -1);
              _cartTotalCount = _cartTotalCount + (isAdd ? 1 : -1);
              notifyListeners();
              if (newCount > 0) {
                product.cartCount = newCount;
              } else {
                product.cartCount = null;
              }

              notifyListeners();

              return;
            }
          }
        }
      }
    }
  }

  // Future getTotalCartCount() async {
  //   final box = await Hive.openBox<CartItem>(
  //     'cart',
  //   );
  //   int totalCartCount = 0;

  //   for (int i = 0; i < box.length; i++) {
  //     final cartItem = box.getAt(i);
  //     if (cartItem != null) {
  //       totalCartCount += cartItem.quantity;
  //       _cartTotalCount = totalCartCount;
  //       notifyListeners();
  //     }
  //   }

  //   await box.close();
  //   await Hive.close();
  //   return totalCartCount;
  // }

  final List<CartItem> _cartItems = <CartItem>[];
  List<CartItem> get cartItems => _cartItems;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  double _taxes = 57;
  double get taxes => _taxes;

  Future<List<CartItem>> getAllCartItems() async {
    final box = await Hive.openBox<CartItem>('cart');
    setFaqLoader(true);
    _cartItems.clear();

    for (int i = 0; i < box.length; i++) {
      final cartItem = box.getAt(i);
      if (cartItem != null) {
        _cartItems.add(cartItem);
        setFaqLoader(false);
        inspect(_cartItems);
      }
    }

    await box.close();
    _totalPrice = _cartItems.fold(
        0,
        (previousValue, cartItem) =>
            previousValue + cartItem.price * cartItem.quantity);

    return _cartItems;
  }

  void clearCart() async {
    final box = await Hive.openBox<CartItem>('cart');
    await box.clear();
    _cartItems.clear();
    _totalPrice = 0;
    getAllCartItems();
    _taxes = 0;
    getFaqDetails();
    _cartTotalCount = 0;
    notifyListeners();
  }
}
