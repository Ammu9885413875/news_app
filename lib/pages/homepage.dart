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
        length: 6,
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TabBar(tabAlignment: TabAlignment.start,isScrollable: true,tabs: [
                    Tab(child: Container(
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1.5),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Sports')),
                      ),),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('Politics')),
                          )),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: Container(
                              width: 120,
                              decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('Technology')),
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('Science')),
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('Health')),
                          ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Tab(child: Container(
                          width: 120,
                          decoration: BoxDecoration(
                              border: Border.all(width: 1.5),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(child: Text('Entertainment')),
                          ))),
                    )
                  ]),
                ),
                Expanded(
                  child: TabBarView(children: [
                    MyCategoryPage(category: 'sports',),
                    MyCategoryPage(category: 'politics',),
                    MyCategoryPage(category: 'technology',),
                    MyCategoryPage(category: 'science',),
                    MyCategoryPage(category: 'health',),
                    MyCategoryPage(category: 'entertainment',)
                  ]),
                ),
              ],
            )
        ));
  }
}