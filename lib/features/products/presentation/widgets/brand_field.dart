import 'package:admin/features/brands/domain/entities/brand.dart';
import 'package:admin/features/brands/domain/repos/brand_repo.dart';
import 'package:admin/shared/widgets/field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BrandField extends StatefulWidget {
  final Brand? value;
  final void Function(Brand?)? onChanged;
  const BrandField({super.key, required this.value, required this.onChanged});

  @override
  State<BrandField> createState() => _BrandFieldState();
}

class _BrandFieldState extends State<BrandField> {
  List<Brand> brands = [];

  @override
  void initState() {
    super.initState();
    _readBrands();
  }

  void _readBrands() async =>
      brands = await context.read<BrandRepo>().readAllBrands();

  List<Brand> _filteredBrands(String searchQuery) =>
      brands.where((b) => b.name.toLowerCase().contains(searchQuery)).toList();

  @override
  Widget build(BuildContext context) {
    return Field(
      label: 'Marca',
      child: Select<Brand>(
        itemBuilder: (context, item) {
          return Text(item.name);
        },
        // ignore: implicit_call_tearoffs
        popup: SelectPopup.builder(
          searchPlaceholder: Text('Buscar marca'),
          builder: (context, searchQuery) {
            final filteredBrands = searchQuery == null
                ? brands
                : _filteredBrands(searchQuery);
            return SelectItemList(
              children: filteredBrands
                  .map((b) => SelectItemButton(value: b, child: Text(b.name)))
                  .toList(),
            );
          },
        ),
        onChanged: widget.onChanged,
        constraints: BoxConstraints(minWidth: double.maxFinite),
        value: widget.value,
        placeholder: Text('Seleccionar marca'),
      ),
    );
  }
}
