import 'package:clay_containers/clay_containers.dart';
import 'package:newsapp/pages/category_page.dart';
import 'profilepage.dart';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget{
  const MyHomePage({super.key,});
  @override
  State<StatefulWidget> createState() {
    return MyHomePageState();
  }
}
class MyHomePageState extends State<MyHomePage> {
  String category='sports';
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              title: const Text('News App',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => MyProfilePage()));
                  },
                  icon: const Icon(Icons.person_3),
                  iconSize: 50,
                  color: Colors.blueGrey,)
              ],
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .inversePrimary,
            ),
            body: Column(
              children: [
                TabBar(tabs: [
                  Tab(child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(width: 1.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sports'),
                    ),),),
                  Tab(child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Politics'),
                      )),),
                  Tab(child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Technology'),
                      )))
                ]),
                Expanded(
                  child: TabBarView(children: [
                    MyCategoryPage(category: 'sports',),
                    MyCategoryPage(category: 'politics',),
                    MyCategoryPage(category: 'technology',),
                  ]),
                ),
              ],
            )
        ));
  }
}