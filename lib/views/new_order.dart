import 'package:flutter/material.dart';

class NewOrder extends StatelessWidget {
  const NewOrder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Nueva orden")),
      body: const Center(
        child: Text("Nueva orden"),
      ),
    );
  }
}
