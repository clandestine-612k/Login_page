import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/auth_bloc.dart';
import 'package:to_do_app/loginscreen.dart';
import 'package:to_do_app/widgets/gradient_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
              (route) => false);
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return Center(
          child: Column(
            children: [
              Center(
                child: Text((state as AuthSuccess).uid),
              ),
              GradientButton(onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              })
            ],
          ),
        );
      }),
    );
  }
}
