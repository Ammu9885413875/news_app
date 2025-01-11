import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/pages/my_sign_up_page.dart';
import 'package:newsapp/widgets/bottom_nav_bar.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromRGBO(
            130, 194, 227, 1.0)),
        useMaterial3: true,
      ),
      // home: FutureBuilder<Widget>(
      //   future: navigateToPage(),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     } else if (snapshot.hasError) {
      //       return Center(child: Text('Error: ${snapshot.error}'));
      //     } else {
      //       return snapshot.data!;
      //     }
      //   },
      // ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, snapshot) {
        if(snapshot.hasData){
          return NavigationBars();
        }
        else{
          return MyLoginPage();
        }
      },),
    );
  }
  // Future<Widget> navigateToPage() async{
  //   SharedPreferences prefs=await SharedPreferences.getInstance();
  //   bool isLoggedIn=prefs.getBool('isLoggedIn')??false;
  //   if(isLoggedIn){
  //     return NavigationBars();
  //   }
  //   return MyLoginPage(title: 'Create profile',);
  // }
}