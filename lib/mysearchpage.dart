import 'package:flutter/material.dart';
class MySearchPage extends StatelessWidget{
  const MySearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: TextField(
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.black,width: 3),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Colors.blue,width: 4),
            ),
            prefixIcon:const Icon(Icons.search),
            hintText: 'Search Here ..........',
          ),
        ),
      ),
    );
  }

}