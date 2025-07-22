import 'package:admin/features/brands/domain/entities/brand.dart';
import 'package:admin/features/categories/domain/entities/category.dart';

class Product {
  final String? id;
  final String code;
  final String name;
  final String description;
  final int stock;
  final double buyPrice;
  final double sellPrice;
  final Category category;
  final Brand brand;

  Product({
    this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.stock,
    required this.buyPrice,
    required this.sellPrice,
    required this.category,
    required this.brand,
  });

  Map<String, dynamic> toMap() => {
    'code': code,
    'name': name,
    'description': description,
    'stock': stock,
    'buy_price': buyPrice,
    'sell_price': sellPrice,
    'category_id': category.id,
    'brand_id': brand.id,
  };

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    id: map['id'],
    code: map['code'],
    name: map['name'],
    description: map['description'],
    stock: map['stock'],
    buyPrice: map['buy_price'] as double,
    sellPrice: map['sell_price'] as double,
    category: Category.fromMap(map['category']),
    brand: Brand.fromMap(map['brand']),
  );
}
