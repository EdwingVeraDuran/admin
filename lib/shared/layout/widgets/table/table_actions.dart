import 'package:shadcn_flutter/shadcn_flutter.dart';

class TableActions extends StatelessWidget {
  final void Function(BuildContext)? onEdit;
  final void Function(BuildContext)? onDelete;
  const TableActions({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return IconButton.outline(
      icon: Icon(LucideIcons.ellipsis),
      size: ButtonSize.small,
      onPressed: () {
        showDropdown(
          context: context,
          builder: (context) => DropdownMenu(
            children: [
              MenuButton(
                leading: Icon(LucideIcons.pencil),
                onPressed: onEdit,
                child: Text('Editar'),
              ),
              MenuButton(
                leading: Icon(
                  LucideIcons.trash,
                  color: Theme.of(context).colorScheme.destructive,
                ),
                onPressed: onDelete,
                child: Text('Eliminar'),
              ),
            ],
          ),
        );
      },
    );
  }
}
