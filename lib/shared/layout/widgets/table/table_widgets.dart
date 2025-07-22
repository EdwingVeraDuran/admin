import 'package:admin/shared/layout/widgets/table/table_actions.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

TableCell tableHeaderCell(String label, [bool alignRight = false]) {
  return TableCell(
    child: Container(
      margin: const EdgeInsets.all(8),
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(label).muted().semiBold(),
    ),
  );
}

TableCell tableCell(String label, [bool alignRight = false]) {
  return TableCell(
    child: Container(
      margin: const EdgeInsets.all(8),
      alignment: alignRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Text(label),
    ),
  );
}

TableCell categoryCell(String label) {
  return TableCell(
    child: Container(
      padding: const EdgeInsets.all(8),
      alignment: Alignment.centerLeft,
      child: Chip(style: ButtonStyle.secondary(), child: Text(label)),
    ),
  );
}

TableCell actionsCell({
  required void Function(BuildContext)? onEdit,
  required void Function(BuildContext)? onDelete,
}) {
  return TableCell(
    child: Container(
      width: 100,
      margin: const EdgeInsets.all(8),
      alignment: Alignment.center,
      child: TableActions(onEdit: onEdit, onDelete: onDelete),
    ),
  );
}
