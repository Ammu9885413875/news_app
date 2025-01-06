import 'package:flutter/material.dart';
import 'package:newsapp/pages/homepage.dart';
import 'package:newsapp/widgets/bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyLoginPage extends StatefulWidget {
  final String title;
  const MyLoginPage({super.key,required this.title});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  var userName=TextEditingController();
  var bio=TextEditingController();
  var phoneNo=TextEditingController();
  var email=TextEditingController();
  @override
  Widget build(BuildContext context) {
    String title=widget.title;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextField(
            keyboardType: TextInputType.text,
            controller: userName,
            decoration: InputDecoration(
              hintText: 'Username',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.black,
                )
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(20),
              )

            ),
          ),
          TextField(
            keyboardType: TextInputType.multiline,
            minLines: 1,
            maxLines: 3,
            controller: bio,
            decoration: InputDecoration(
              hintText: 'A brief bio',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          TextField(
            keyboardType: TextInputType.phone,
            controller: phoneNo,
            decoration: InputDecoration(
              hintText: 'Phone number',
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            decoration: InputDecoration(
              hintText: 'email',
                 enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.black,
                    )
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                )

            ),
          ),
          ElevatedButton(onPressed: (){
            storeAll();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>NavigationBars()),(route)=>false);
          }, child: Text('Submit'))
        ],
      ),
    );
  }

  void storeAll() async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setString('userName', userName.text.toString());
    prefs.setString('bio', bio.text.toString());
    prefs.setString('phoneNo', phoneNo.text.toString());
    prefs.setString('email', email.text.toString());
    prefs.setBool('isLoggedIn', true);
  }
}
