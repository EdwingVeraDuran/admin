import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/auth/presentation/bloc/auth_event.dart';
import 'package:admin/shared/layout/pages/inventory_page.dart';
import 'package:admin/shared/layout/pages/orders_page.dart';
import 'package:admin/shared/widgets/scroll_config.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DashboardLayout extends StatefulWidget {
  const DashboardLayout({super.key});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool isInventory = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: HiddenScroll(
        child: Column(
          children: [
            _header(),
            Gap(24),
            isInventory ? InventoryPage() : OrdersPage(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SecondaryButton(
          child: Text(isInventory ? 'Inventario' : 'Ordenes').large.semiBold,
          onPressed: () => setState(() => isInventory = !isInventory),
        ),
        IconButton.secondary(
          icon: Icon(LucideIcons.logOut),
          onPressed: () => context.read<AuthBloc>().add(LogoutRequested()),
        ),
      ],
    );
  }
}
