import 'package:admin/features/brands/presentation/section/brands_section.dart';
import 'package:admin/features/categories/presentation/section/categories_section.dart';
import 'package:admin/features/products/presentation/section/products_section.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProductsSection(),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 1, child: CategoriesSection()),
            Gap(16),
            Expanded(flex: 1, child: BrandsSection()),
          ],
        ),
      ],
    );
  }
}
