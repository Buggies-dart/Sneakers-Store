import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Widgets/userOnboarding/login.dart';
import 'package:sneaker_store_app/authentication/firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool isLoading = false;
   final TextEditingController controllerMail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerUserName = TextEditingController();
  void onTap() async{
    setState(() {
      isLoading = true;
    });
    await FirebaseAuthMethods(FirebaseAuth.instance).signUpWithMail(username: controllerUserName.text,
     mail: controllerMail.text, password: controllerPassword.text, context: context);
    setState(() {
      isLoading = false;
    });
  }
  void googleAuth(){
    FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle(context);
  }
   @override
  void dispose() {
    controllerMail.dispose();
    controllerPassword.dispose();
    controllerUserName.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(  backgroundColor: const Color.fromARGB(255, 245, 243, 243),
      body: isLoading == true? const Center(
     child: CircularProgressIndicator.adaptive(),
      ):
      SafeArea( 
        child: 
      Column( 
       children: [
        const SizedBox( height: 50,),
       const Text('Sign Up', style: TextStyle( fontWeight: FontWeight.bold,
        fontSize: 30, color: Colors.black)
       ),
        const SizedBox( height: 20,),
        signupFields('Email', controllerMail),
        signupFields('Username', controllerUserName),
        signupFields('Password', controllerPassword),
        const SizedBox( height: 50,),
         Padding(
           padding: const EdgeInsets.only(left: 25, right: 25),
           child: ElevatedButton( style: ElevatedButton.styleFrom( backgroundColor: Colors.blue[400],
           minimumSize: const Size(double.infinity, 50),
           padding: const EdgeInsets.only(top: 15, bottom: 15),
           shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10),
           bottom: Radius.circular(10))
           )
           )
           , 
            onPressed: onTap, child: const Text('Sign Up',
                   style: TextStyle( fontWeight: FontWeight.bold,
                   fontSize: 20, color: Colors.white), 
                   ),
                   ),
         ),
         const SizedBox( height: 20),
      const Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Flexible(
      child: Padding(
        padding:  EdgeInsets.only(left: 30.0, right: 10), 
        child: Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ),
    ),
    Text('or'),
    Flexible(
      child: Padding(
        padding:  EdgeInsets.only(right: 30.0, left: 10),
        child: Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ),
    ),
  ],
),
 Row( mainAxisAlignment: MainAxisAlignment.center,
  children: [
    smSignupIcon(MdiIcons.google, googleAuth),
    smSignupIcon(Icons.facebook, (){}),
    smSignupIcon(MdiIcons.cellphone, (){})
       
       ]),
  
     Row( children: [ const SizedBox( width: 50,),
      const Text('Do you already have an account?', style: TextStyle(fontSize: 15),),
    TextButton(onPressed: (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){ return
        const Login();
      }));
    }, child: const Text('Sign in',)) ],)]
      )
      )
    );
  }

  Widget signupFields(String data, TextEditingController controller) {
    return Padding( padding: const EdgeInsets.only( right: 30, left: 30, bottom: 15),
      child: TextField( controller: controller,
          decoration: InputDecoration( filled: true, fillColor: Colors.white,
           hintText: data, contentPadding: const EdgeInsets.all(12),
           focusedBorder: const OutlineInputBorder( borderSide: BorderSide.none),
           border: const OutlineInputBorder( borderSide: BorderSide.none)
          ),
        ),
    );
  }
  Widget smSignupIcon(IconData icon, VoidCallback onTap){
    return IconButton(onPressed: onTap, icon: Icon(icon, size: 35,));
   }
}