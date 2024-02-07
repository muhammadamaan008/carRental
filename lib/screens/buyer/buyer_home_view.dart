import 'package:flutter/material.dart';

class BuyerHomeView extends StatelessWidget {
  const BuyerHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Buyer View'),
      ),
    );
  }
}