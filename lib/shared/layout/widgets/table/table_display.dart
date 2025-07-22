import 'package:admin/shared/layout/widgets/table/custom_pagination.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableDisplay extends StatelessWidget {
  final TableRow tableHeader;
  final List<TableRow> tableData;
  final int pageSize;
  final int page;
  final int totalPages;
  final void Function(int?) onChangePageSize;
  final void Function(int) onChangePage;
  const TableDisplay({
    super.key,
    required this.tableHeader,
    required this.tableData,
    required this.pageSize,
    required this.page,
    required this.totalPages,
    required this.onChangePageSize,
    required this.onChangePage,
  });

  Map<int, TableSize> _generateColumnWidths() {
    final totalColumns = tableHeader.cells.length;

    return {
      for (int i = 0; i < totalColumns; i++)
        i: i == totalColumns - 1 ? IntrinsicTableSize() : FlexTableSize(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedContainer(
          clipBehavior: Clip.hardEdge,
          child: Table(
            defaultRowHeight: FixedTableSize(50),
            columnWidths: _generateColumnWidths(),
            rows: [tableHeader, ...tableData],
          ),
        ),
        Gap(24),
        CustomPagination(
          pageSize: pageSize,
          page: page,
          totalPages: totalPages,
          onChangePage: onChangePage,
          onChangePageSize: onChangePageSize,
        ),
      ],
    );
  }
}
