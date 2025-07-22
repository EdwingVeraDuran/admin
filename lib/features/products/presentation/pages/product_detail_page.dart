import 'dart:io';

import 'package:admin/features/brands/domain/entities/brand.dart';
import 'package:admin/features/categories/domain/entities/category.dart';
import 'package:admin/features/products/domain/entities/product.dart';
import 'package:admin/features/products/presentation/bloc/product_bloc.dart';
import 'package:admin/features/products/presentation/bloc/product_event.dart';
import 'package:admin/features/products/presentation/widgets/brand_field.dart';
import 'package:admin/features/products/presentation/widgets/buy_price_field.dart';
import 'package:admin/features/products/presentation/widgets/category_field.dart';
import 'package:admin/features/products/presentation/widgets/code_field.dart';
import 'package:admin/features/products/presentation/widgets/description_field.dart';
import 'package:admin/features/products/presentation/widgets/dropzone.dart';
import 'package:admin/features/products/presentation/widgets/name_field.dart';
import 'package:admin/features/products/presentation/widgets/sell_price_field.dart';
import 'package:admin/features/products/presentation/widgets/stock_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProductDetailPage extends StatefulWidget {
  final Product? product;
  const ProductDetailPage({super.key, this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  String name = '';
  String description = '';
  String code = '';
  int stock = 0;
  double buyPrice = 0;
  double sellPrice = 0;
  Category? category;
  Brand? brand;
  File? image;

  @override
  void initState() {
    if (widget.product != null) setData(widget.product!);
    super.initState();
  }

  void setData(Product product) {
    name = product.name;
    description = product.description;
    code = product.code;
    stock = product.stock;
    buyPrice = product.buyPrice;
    sellPrice = product.sellPrice;
    category = product.category;
    brand = product.brand;
  }

  void send() {
    if (name.isEmpty) return;
    if (description.isEmpty) return;
    if (code.isEmpty) return;
    if (buyPrice <= 0) return;
    if (sellPrice <= 0) return;
    if (category == null) return;
    if (brand == null) return;

    final Product product = Product(
      id: widget.product?.id,
      code: code,
      name: name,
      description: description,
      stock: stock,
      buyPrice: buyPrice,
      sellPrice: sellPrice,
      category: category!,
      brand: brand!,
    );
    widget.product != null
        ? context.read<ProductBloc>().add(UpdateProduct(product, image))
        : context.read<ProductBloc>().add(CreateProduct(product, image!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: 600,
              child: Card(
                child: Column(
                  spacing: 24,
                  children: [
                    Dropzone(
                      file: image,
                      isEditing: widget.product != null,
                      onChanged: (value) => setState(() => image = value),
                    ),
                    NameField(
                      initialValue: name,
                      onChanged: (value) => setState(() => name = value),
                    ),
                    DescriptionField(
                      initialValue: description,
                      onChanged: (value) => setState(() => description = value),
                    ),
                    _row(
                      CodeField(
                        initialValue: code,
                        onChanged: (value) => setState(() => code = value),
                      ),
                      StockField(
                        initialValue: stock.toString(),
                        onChanged: (value) =>
                            setState(() => stock = int.tryParse(value) ?? 0),
                      ),
                    ),
                    _row(
                      BuyPriceField(
                        initialValue: buyPrice.toString(),
                        onChanged: (value) => setState(
                          () => buyPrice = double.tryParse(value) ?? 0,
                        ),
                      ),
                      SellPriceField(
                        initialValue: sellPrice.toString(),
                        onChanged: (value) => setState(
                          () => sellPrice = double.tryParse(value) ?? 0,
                        ),
                      ),
                    ),
                    _row(
                      CategoryField(
                        value: category,
                        onChanged: (value) => setState(() => category = value),
                      ),
                      BrandField(
                        value: brand,
                        onChanged: (value) => setState(() => brand = value),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: 12,
                      children: [
                        SecondaryButton(
                          child: Text('Cancelar'),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        PrimaryButton(
                          onPressed: send,
                          child: Text(
                            widget.product != null ? 'Actualizar' : 'Crear',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _row(Widget input1, Widget input2) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(flex: 1, child: input1),
      Gap(24),
      Expanded(flex: 1, child: input2),
    ],
  );
}
