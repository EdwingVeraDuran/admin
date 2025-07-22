import 'package:admin/app.dart';
import 'package:admin/core/services/supabase_service.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SupabaseService.init();
  runApp(const AdminApp());
}
