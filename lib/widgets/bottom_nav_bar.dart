import 'package:flutter/material.dart';
import 'package:newsapp/pages/mysavedpage.dart';
import 'package:newsapp/pages/mysearchpage.dart';
import 'package:newsapp/pages/homepage.dart';
class NavigationBars extends StatefulWidget {
  const NavigationBars({super.key});
  @override
  State<NavigationBars> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBars> {
  int selectedIndex=0;
  onItemTapped(index){
    selectedIndex=index;
    setState(() {
    });
  }
  final pages=const[
    MyHomePage(),
    MySearchPage(),
    MySavedPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,weight: 15,),label: 'Home',),
        BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,weight: 15,),label: 'Search'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark_outline,size: 30,weight:
        15),label: 'Saved Items'),
      ],
      currentIndex: selectedIndex,onTap: onItemTapped,selectedItemColor: Colors.blue,unselectedItemColor: Colors.grey,
      ),
      body:pages[selectedIndex],
    );
  }
}
