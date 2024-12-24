import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget{
  const MyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title:const Text('Profile page',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClayContainer(
            height: 400,
            spread: 30,
            customBorderRadius: BorderRadius.only(topRight: Radius.circular(50),bottomLeft: Radius.circular(50)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClayContainer(height: 100,
                    width: 100,
                    borderRadius: 50,
                    spread: 25,child: Center(child: const Text('R',style: TextStyle(fontSize: 50,fontWeight:FontWeight.bold,fontStyle: FontStyle.italic),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Username : rocky@123',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'email : rocky123@gmail.com',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    'Phone no : 1234567890',
                    style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}