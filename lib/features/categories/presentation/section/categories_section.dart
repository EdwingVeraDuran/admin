import 'package:admin/features/categories/domain/entities/category.dart';
import 'package:admin/features/categories/presentation/bloc/category_bloc.dart';
import 'package:admin/features/categories/presentation/bloc/category_event.dart';
import 'package:admin/features/categories/presentation/bloc/category_state.dart';
import 'package:admin/shared/layout/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:admin/shared/layout/widgets/dialogs/single_input_dialog.dart';
import 'package:admin/shared/layout/widgets/sections/create_button.dart';
import 'package:admin/shared/layout/widgets/sections/section.dart';
import 'package:admin/shared/layout/widgets/table/table_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Section(
          title: 'Categorías',
          actionButton: CreateButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) => SingleInputDialog(
                title: 'Crear categoria',
                placeholder: 'Nombre de categoria',
                onSubmitted: (value) {
                  if (value.isEmpty) return;
                  context.read<CategoryBloc>().add(
                    CreateCategory(Category(name: value)),
                  );
                },
              ),
            ),
          ),
          tableHeader: _header(),
          tableData: state is CategoriesList ? _data(state.categories) : [],
          onSearch: (query) => context.read<CategoryBloc>().add(
            query.isNotEmpty ? SearchCategories(query) : ReadCategories(),
          ),
          isEmpty: state is CategoriesEmpty,
          isLoading: state is CategoriesLoading,
          errorMessage: state is CategoriesError ? state.message : null,
          pageSize: state is CategoriesList ? state.pageSize : 10,
          page: state is CategoriesList ? state.page : 1,
          totalPages: state is CategoriesList ? state.totalPages : 1,
          onChangePage: (value) =>
              context.read<CategoryBloc>().add(ChangePage(value)),
          onChangePageSize: (value) =>
              context.read<CategoryBloc>().add(ChangePageSize(value!)),
        );
      },
    );
  }

  TableRow _header() =>
      TableRow(cells: [tableHeaderCell('Nombre'), tableHeaderCell('Acciones')]);

  List<TableRow> _data(List<Category> categories) => categories
      .map(
        (c) => TableRow(
          cells: [
            tableCell(c.name),
            actionsCell(
              onEdit: (context) => showDialog(
                context: context,
                builder: (context) => SingleInputDialog(
                  title: 'Editar categoria',
                  placeholder: 'Nombre de categoria',
                  value: c.name,
                  onSubmitted: (value) {
                    if (value.isEmpty) return;
                    context.read<CategoryBloc>().add(
                      UpdateCategory(Category(id: c.id, name: value)),
                    );
                  },
                ),
              ),
              onDelete: (context) => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  onConfirm: () {
                    context.read<CategoryBloc>().add(DeleteCategory(c.id!));
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
