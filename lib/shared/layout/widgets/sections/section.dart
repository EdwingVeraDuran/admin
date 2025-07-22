import 'package:admin/shared/layout/widgets/sections/search_field.dart';
import 'package:admin/shared/layout/widgets/table/table_display.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class Section extends StatelessWidget {
  final String title;
  final Widget actionButton;
  final TableRow tableHeader;
  final List<TableRow> tableData;
  final void Function(String) onSearch;
  final bool? isLoading;
  final bool? isEmpty;
  final String? errorMessage;
  final int pageSize;
  final int page;
  final int totalPages;
  final void Function(int?) onChangePageSize;
  final void Function(int) onChangePage;
  const Section({
    super.key,
    required this.title,
    required this.actionButton,
    required this.tableHeader,
    required this.tableData,
    required this.onSearch,
    this.isLoading = false,
    this.isEmpty = false,
    this.errorMessage,
    required this.pageSize,
    required this.page,
    required this.totalPages,
    required this.onChangePageSize,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Text(title).large.semiBold,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SearchField(onChanged: onSearch),
            actionButton,
          ],
        ),
        _build(),
      ],
    );
  }

  Widget _build() {
    if (isLoading!) {
      return Center(child: CircularProgressIndicator());
    } else if (isEmpty!) {
      Center(child: Text('No hay registros'));
    } else if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }
    return TableDisplay(
      tableHeader: tableHeader,
      tableData: tableData,
      pageSize: pageSize,
      page: page,
      totalPages: totalPages,
      onChangePage: onChangePage,
      onChangePageSize: onChangePageSize,
    );
  }
}
