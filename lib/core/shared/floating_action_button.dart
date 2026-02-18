import 'package:flutter/material.dart';

class FloatingAction extends StatelessWidget {
  const FloatingAction({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {
      // context.read<AuthBloc>().add(
      //   GetUserRequested(),
      // );
      // context.read<AuthBloc>().add(
      //   LogoutRequested(),
      // );
    }, shape: const CircleBorder(),
      child: const Icon(Icons.support_agent, color: Colors.white,),
    );
  }
}
