import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:newsapp/pages/my_signin_page.dart';
import 'package:newsapp/pages/profile_creation_page.dart';
import 'package:newsapp/widgets/snackBar.dart';
class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}
class _MyLoginPageState extends State<MyLoginPage> {
  bool isLoading=false;
  var email=TextEditingController();
  var password=TextEditingController();
  var confirmPassword=TextEditingController();
  bool isVisible=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Theme.of(context).colorScheme.inversePrimary,
        title: Text('Login to NewsApp',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 35)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              controller: email,
              decoration: InputDecoration(
                  hintText: 'Enter email',
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: isVisible,
              controller: password,
              decoration: InputDecoration(
                  suffixIcon: InkWell(onTap: (){
                    isVisible=!isVisible;
                    setState(() {

                    });
                  },
                    child: Icon(Icons.remove_red_eye_outlined),),
                  hintText: 'Enter Password',
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              controller: confirmPassword,
              decoration: InputDecoration(
                  hintText: 'Confirm your password',
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
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 50,
              child: InkWell(onTap: () async{
                if(email.text.toString().isEmpty||password.text.toString().isEmpty)
                {
                  var mySnack=SnackBarWidget();
                  mySnack.showSnackBar('Email/ Password can\'t be empty', Colors.redAccent, context);
                }
                else if(password.text.toString()!=confirmPassword.text.toString())
                {
                  var mySnack=SnackBarWidget();
                  mySnack.showSnackBar('Password and confirm password don\'t match', Colors.redAccent, context);
                }
                else{
                  try {
                    await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: email.text.toString(),
                      password: password.text.toString(),
                    );
                    var mySnack=SnackBarWidget();
                    mySnack.showSnackBar('Authentication successful', Colors.greenAccent, context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfileCreation(title: 'Create profile',enabled: true,)));
                  }on FirebaseAuthException catch(e){
                  if(e.code=='weak-password'){
                    var mySnack=SnackBarWidget();
                    mySnack.showSnackBar('Password is too weak. Set a strong password.', Colors.redAccent, context);
                  }
                  else if(e.code=='email-already-in-use'){
                    var mySnack=SnackBarWidget();
                    mySnack.showSnackBar('Email already in use.', Colors.redAccent, context);
                  }
                }catch(e){
                    var mySnack=SnackBarWidget();
                    mySnack.showSnackBar('An unexpected error occurred....', Colors.redAccent, context);
                  }
                }
              }, child: Center(child: Text('Submit'))),
            ),
          ),
          isLoading?CircularProgressIndicator():InkWell(onTap: (){
            setState(() {
              isLoading=true;
            });
            signInWithGoogle();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProfileCreation(title: 'Create profile', enabled: false)));
            setState(() {
              isLoading=false;
            });
          }, child: SizedBox(width:30,height:30,child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.asset('assets/images/google.jpeg')))),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Already an user'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MySignIn()));
                    },
                    child: Text('SignIn',style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Future<UserCredential?> signInWithGoogle() async{
    try{
      final user=await GoogleSignIn().signIn();
      final auth=await user?.authentication;
      final credential=GoogleAuthProvider.credential(idToken: auth?.idToken,accessToken: auth?.accessToken);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    catch(e){
      SnackBarWidget mySnack=SnackBarWidget();
      mySnack.showSnackBar('Something wrong...', Colors.redAccent, context);
    }
    return null;
  }

  navigateBack() {
    Navigator.pop(context);
  }
}
