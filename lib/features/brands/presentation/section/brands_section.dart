import 'package:admin/features/brands/domain/entities/brand.dart';
import 'package:admin/features/brands/presentation/bloc/brand_bloc.dart';
import 'package:admin/features/brands/presentation/bloc/brand_event.dart';
import 'package:admin/features/brands/presentation/bloc/brand_state.dart';
import 'package:admin/shared/layout/widgets/dialogs/confirm_delete_dialog.dart';
import 'package:admin/shared/layout/widgets/sections/popover_button.dart';
import 'package:admin/shared/layout/widgets/sections/section.dart';
import 'package:admin/shared/layout/widgets/table/table_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BrandsSection extends StatelessWidget {
  const BrandsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandBloc, BrandState>(
      builder: (context, state) {
        return Section(
          title: 'Marcas',
          actionButton: PopoverButton(
            placeholder: 'Nombre',
            onSubmitted: (value) =>
                context.read<BrandBloc>().add(CreateBrand(Brand(name: value))),
          ),
          tableHeader: _header(),
          tableData: state is BrandsList ? _data(state.brands) : [],
          onSearch: (query) => context.read<BrandBloc>().add(
            query.isNotEmpty ? SearchBrands(query) : ReadBrands(),
          ),
          isEmpty: state is BrandsEmpty,
          isLoading: state is BrandsLoading,
          errorMessage: state is BrandsError ? state.message : null,
          pageSize: state is BrandsList ? state.pageSize : 10,
          page: state is BrandsList ? state.page : 1,
          totalPages: state is BrandsList ? state.totalPages : 1,
          onChangePage: (value) =>
              context.read<BrandBloc>().add(ChangePage(value)),
          onChangePageSize: (value) =>
              context.read<BrandBloc>().add(ChangePageSize(value!)),
        );
      },
    );
  }

  TableRow _header() =>
      TableRow(cells: [tableHeaderCell('Nombre'), tableHeaderCell('Acciones')]);

  List<TableRow> _data(List<Brand> brands) => brands
      .map(
        (b) => TableRow(
          cells: [
            tableCell(b.name),
            actionsCell(
              onEdit: (context) => showPopover(
                context: context,
                alignment: Alignment.topCenter,
                offset: Offset(0, 8),
                builder: (context) => ModalContainer(
                  child: SizedBox(
                    width: 200,
                    child: TextField(
                      initialValue: b.name,
                      onSubmitted: (value) {
                        context.read<BrandBloc>().add(
                          UpdateBrand(Brand(id: b.id, name: value)),
                        );
                        closeOverlay(context);
                      },
                    ),
                  ),
                ),
              ),
              onDelete: (context) => showDialog(
                context: context,
                builder: (context) => ConfirmDeleteDialog(
                  onConfirm: () {
                    context.read<BrandBloc>().add(DeleteBrand(b.id!));
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
