import 'package:shadcn_flutter/shadcn_flutter.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadcnApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorSchemes.lightRose(), radius: 1),
    );
  }
}
