import 'package:admin/features/categories/domain/entities/category.dart';
import 'package:admin/features/categories/domain/repos/category_repo.dart';
import 'package:admin/shared/widgets/field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CategoryField extends StatefulWidget {
  final Category? value;
  final void Function(Category?)? onChanged;
  const CategoryField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<CategoryField> createState() => _CategoryFieldState();
}

class _CategoryFieldState extends State<CategoryField> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _readCategories();
  }

  void _readCategories() async {
    categories = await context.read<CategoryRepo>().readAllCategories();
  }

  List<Category> _filteredCategorys(String searchQuery) => categories
      .where((c) => c.name.toLowerCase().contains(searchQuery))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Field(
      label: 'Categoría',
      child: Select<Category>(
        itemBuilder: (context, item) {
          return Text(item.name);
        },
        // ignore: implicit_call_tearoffs
        popup: SelectPopup.builder(
          searchPlaceholder: Text('Buscar categoría'),
          builder: (context, searchQuery) {
            final filteredCategorys = searchQuery == null
                ? categories
                : _filteredCategorys(searchQuery);
            return SelectItemList(
              children: filteredCategorys
                  .map((c) => SelectItemButton(value: c, child: Text(c.name)))
                  .toList(),
            );
          },
        ),
        onChanged: widget.onChanged,
        constraints: BoxConstraints(minWidth: double.maxFinite),
        value: widget.value,
        placeholder: Text('Seleccione categoría'),
      ),
    );
  }
}
