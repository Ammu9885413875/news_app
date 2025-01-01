import 'package:flutter/material.dart';
class MySavedPage extends StatelessWidget{
  const MySavedPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Saved Items',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),

      ),
    );
  }
}