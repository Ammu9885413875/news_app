import 'package:flutter/material.dart';
import 'package:newsapp/pages/category_page.dart';
class MySearchPage extends StatefulWidget{
  const MySearchPage({super.key});

  @override
  State<MySearchPage> createState() => _MySearchPageState();
}
class _MySearchPageState extends State<MySearchPage> {
  String? category;

  var searchText=TextEditingController();
  String? text;
  var isSelected=[false,false,false,false,false,false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('News App',style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
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
                suffixIcon: IconButton(onPressed: (){

                  setState(() {
                    text=searchText.text.toString();
                  });
                }, icon: Icon(Icons.arrow_forward_rounded)),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                categoryButton(category: 'Sports', index: 0),
                categoryButton(category: 'Politics', index: 1),
                categoryButton(category: 'Technology', index: 2),
                categoryButton(category: 'Science', index: 3),
                categoryButton(category: 'Health', index: 4),
                categoryButton(category: 'Environment', index: 5),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FutureBuilder<Widget>(
                future: showContent(), // Use FutureBuilder to get the initial page
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    // While waiting for the future to complete, show a loading indicator
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    // Handle any errors that occur during the future
                    return Center(child: Text('Couldn\'t process the request'));
                  } else {
                    // Once the future completes, return the appropriate page
                    return snapshot.data!;
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget categoryButton({required String category, required int index}) {
    return SizedBox(
      height: 60,
      width: 130,// Set the height of the button
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected[index] ? Colors.blue : Colors.grey,
            minimumSize: Size(60, 30), // Set minimum size to control width and height
            padding: EdgeInsets.all(8), // Remove internal padding
          ),
          onPressed: () {
            setState(() {
              isSelected = [false, false, false, false, false, false];
              isSelected[index] = true;
              this.category = category.toLowerCase();
              text = searchText.text.toString();
            });
          },
          child: Text(category, style: TextStyle(fontSize: 12)), // Adjust font size if needed
        ),
      ),
    );
  }
  Future<Widget> showContent() async {
    if(text==null)
    {
        return Center(child: Text('Start searching...'));
    }
    else if(text!.isEmpty)
    {
      return Center(child: Text('Enter something to search'),);
    }
    else if(category==null) {
      return MyCategoryPage(searchText: text,);
    }
    return MyCategoryPage(category: category,searchText: text);
  }
}