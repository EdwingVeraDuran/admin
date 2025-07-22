import 'package:admin/app.dart';
import 'package:admin/core/injection.dart';
import 'package:admin/core/services/supabase_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  setupDependencies();
  runApp(const AdminApp());
}
