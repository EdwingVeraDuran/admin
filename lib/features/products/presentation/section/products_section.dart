import 'package:admin/features/products/domain/entities/product.dart';
import 'package:admin/features/products/presentation/bloc/product_bloc.dart';
import 'package:admin/features/products/presentation/bloc/product_event.dart';
import 'package:admin/features/products/presentation/bloc/product_state.dart';
import 'package:admin/features/products/presentation/pages/product_detail_page.dart';
import 'package:admin/shared/layout/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:admin/shared/layout/widgets/sections/create_button.dart';
import 'package:admin/shared/layout/widgets/sections/section.dart';
import 'package:admin/shared/layout/widgets/table/table_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Section(
          title: 'Productos',
          actionButton: CreateButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProductDetailPage()),
            ),
          ),
          tableHeader: _header(),
          tableData: state is ProductsList ? _data(state.products) : [],
          onSearch: (query) => context.read<ProductBloc>().add(
            query.isNotEmpty ? SearchProducts(query) : ReadProducts(),
          ),
          isEmpty: state is ProductsEmpty,
          isLoading: state is ProductsLoading,
          errorMessage: state is ProductsError ? state.message : null,
          pageSize: state is ProductsList ? state.pageSize : 10,
          page: state is ProductsList ? state.page : 1,
          totalPages: state is ProductsList ? state.totalPages : 1,
          onChangePage: (value) =>
              context.read<ProductBloc>().add(ChangePage(value)),
          onChangePageSize: (value) =>
              context.read<ProductBloc>().add(ChangePageSize(value!)),
        );
      },
    );
  }

  TableRow _header() => TableRow(
    cells: [
      tableHeaderCell('Código'),
      tableHeaderCell('Nombre'),
      tableHeaderCell('Stock', true),
      tableHeaderCell('Precio Compra', true),
      tableHeaderCell('Precio Venta', true),
      tableHeaderCell('Categoría'),
      tableHeaderCell('Marca'),
      tableHeaderCell('Acciones'),
    ],
  );

  List<TableRow> _data(List<Product> products) => products
      .map(
        (p) => TableRow(
          cells: [
            tableCell(p.code),
            tableCell(p.name),
            tableCell(p.stock.toString(), true),
            tableCell(p.buyPrice.toString(), true),
            tableCell(p.sellPrice.toString(), true),
            tableCell(p.category.name),
            tableCell(p.brand.name),
            actionsCell(
              onEdit: (context) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailPage(product: p),
                ),
              ),
              onDelete: (context) => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  onConfirm: () {
                    context.read<ProductBloc>().add(DeleteProduct(p.id!));
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          ],
        ),
      )
      .toList();
}
