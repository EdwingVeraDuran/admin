import 'package:admin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:admin/features/auth/presentation/bloc/auth_event.dart';
import 'package:admin/shared/widgets/field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();

  void onSend() {
    final emailText = email.text.trim();
    final passwordText = password.text.trim();

    context.read<AuthBloc>().add(LoginRequested(emailText, passwordText));
    email.clear();
    password.clear();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Center(
        child: Card(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              Text('Panel Coqueta Shop').semiBold.x2Large,
              Gap(24),
              Field(
                label: 'Correo',
                child: TextField(controller: email),
              ),
              Gap(8),
              Field(
                label: 'Contraseña',
                child: TextField(
                  controller: password,
                  features: [InputFeature.passwordToggle()],
                  onSubmitted: (value) => onSend,
                ),
              ),
              Gap(32),
              PrimaryButton(onPressed: onSend, child: Text('Entrar')),
            ],
          ),
        ).sized(width: 300).intrinsicHeight(),
      ),
    );
  }
}
