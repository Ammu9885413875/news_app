import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/homepage.dart';
import 'package:newsapp/pages/loginpage.dart';
import 'package:newsapp/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(187, 223, 236, 1.0)),
        useMaterial3: true,
      ),
      home: FutureBuilder<Widget>(
        future: navigateToPage(), // Use FutureBuilder to get the initial page
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While waiting for the future to complete, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors that occur during the future
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            // Once the future completes, return the appropriate page
            return snapshot.data!;
          }
        },
      ),
    );
  }

  Future<Widget> navigateToPage() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    bool isLoggedIn=prefs.getBool('isLoggedIn')??false;
    if(isLoggedIn){
      return MyHomePage();
    }
    return MyLoginPage(title: 'Create profile',);
  }
}