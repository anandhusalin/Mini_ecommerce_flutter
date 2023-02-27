import 'package:hive_flutter/adapters.dart';
part 'db_model.g.dart';

@HiveType(typeId: 1)
class CartItem extends HiveObject {
  @HiveField(0)
  final String name;

  @HiveField(1)
  late final int quantity;

  @HiveField(2)
  final double price;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}
