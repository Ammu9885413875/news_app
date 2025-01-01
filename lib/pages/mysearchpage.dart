import 'package:flutter/material.dart';
class MySearchPage extends StatefulWidget{
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  var searchText=TextEditingController();
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
          controller: searchText,
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
            suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_rounded)),
          ),
        ),
      ),
    );
  }
}