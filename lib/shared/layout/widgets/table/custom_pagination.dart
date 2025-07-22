import 'package:shadcn_flutter/shadcn_flutter.dart';

class CustomPagination extends StatelessWidget {
  final int pageSize;
  final int page;
  final int totalPages;
  final void Function(int?) onChangePageSize;
  final void Function(int) onChangePage;
  const CustomPagination({
    super.key,
    required this.pageSize,
    required this.page,
    required this.totalPages,
    required this.onChangePageSize,
    required this.onChangePage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Select<int>(
          itemBuilder: (context, value) {
            return Text(value.toString());
          },
          onChanged: onChangePageSize,
          value: pageSize,
          // ignore: implicit_call_tearoffs
          popup: SelectPopup(
            items: SelectItemList(
              children: [
                SelectItemButton(value: 10, child: Text('10')),
                SelectItemButton(value: 20, child: Text('20')),
                SelectItemButton(value: 30, child: Text('30')),
                SelectItemButton(value: 40, child: Text('40')),
                SelectItemButton(value: 50, child: Text('50')),
              ],
            ),
          ),
        ),
        Pagination(
          page: page,
          totalPages: totalPages,
          showLabel: false,
          onPageChanged: onChangePage,
        ),
      ],
    );
  }
}
