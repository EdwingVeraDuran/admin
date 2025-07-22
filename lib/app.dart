import 'package:admin/core/injection.dart';
import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/auth/presentation/bloc/auth_state.dart';
import 'package:admin/features/auth/presentation/pages/login_page.dart';
import 'package:admin/features/brands/presentation/bloc/brand_bloc.dart';
import 'package:admin/features/categories/presentation/bloc/category_bloc.dart';
import 'package:admin/features/products/presentation/bloc/product_bloc.dart';
import 'package:admin/shared/layout/dashboard_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<AuthBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
        BlocProvider(create: (context) => sl<BrandBloc>()),
        BlocProvider(create: (context) => sl<CategoryBloc>()),
      ],
      child: ShadcnApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(colorScheme: ColorSchemes.lightRose(), radius: 1),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Scaffold(
                child: Center(child: CircularProgressIndicator()),
              );
            }

            if (state is Authenticated) {
              return DashboardLayout();
            }
            return LoginPage();
          },
        ),
      ),
    );
  }
}
