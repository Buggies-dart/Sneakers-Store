import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Widgets/userOnboarding/forgotpassword.dart';
import 'package:sneaker_store_app/Widgets/userOnboarding/signup.dart';
import 'package:sneaker_store_app/authentication/firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _SignupState();
}
 bool isLoading = false;
 bool obscureText = true;
 
final TextEditingController controllerUserName = TextEditingController();
final TextEditingController controllerPassword = TextEditingController();
class _SignupState extends State<Login> {
final userLogin =    FirebaseAuthMethods(FirebaseAuth.instance);
void googleSignIn() async{
  await FirebaseAuthMethods(FirebaseAuth.instance).signInWithGoogle(context);
}

void onTap() async{
setState(() {
isLoading = true;
});
await userLogin.userSignin(password: controllerPassword.text, username: controllerUserName.text, context: context);
 setState(() {
isLoading = false;
 });    
  }


  @override
  Widget build(BuildContext context) {
return  Scaffold(  backgroundColor: const Color.fromARGB(255, 245, 243, 243),
body:
SafeArea( 
child: 
Column( 
children: [
const SizedBox( height: 50,),
const Text('Welcome Back!', style: TextStyle( fontWeight: FontWeight.bold,
fontSize: 30, color: Colors.black)
),
const SizedBox( height: 20,),
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
), 
onPressed: onTap, child:  isLoading == false? const Text(  'Sign In' ,
style: TextStyle( fontWeight: FontWeight.bold,
fontSize: 20, color: Colors.white), 
) : 

const Row( mainAxisAlignment: MainAxisAlignment.center,
children: [
Text('Signing in', style: TextStyle(fontWeight: FontWeight.bold,
fontSize: 20, color: Colors.white),), 
SizedBox(width: 5),
SizedBox( width: 15, height: 15,
  child: CircularProgressIndicator.adaptive( strokeWidth: 1, backgroundColor: Colors.white60, valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ),
)
  ],),
),
),
TextButton(onPressed: (){
Navigator.push(context, MaterialPageRoute(builder: (context){
return const Forgotpassword();
    }));
}, child: const Text('Forgot Password?',
)),
const SizedBox( height: 20),
const Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
Flexible(
child: Padding(
 padding:  EdgeInsets.only(left: 30.0, right: 10), 
child: Divider(
thickness: 1,color: Colors.black,
),
),
),
Text('or'),
Flexible( child: Padding( padding:  EdgeInsets.only(right: 30.0, left: 10),
child: Divider( thickness: 1, color: Colors.black,
),
),
),
  ],
),
 Row( mainAxisAlignment: MainAxisAlignment.center,
  children: [
    smSignupIcon(MdiIcons.google, googleSignIn),
    smSignupIcon(Icons.facebook, (){}),
    smSignupIcon(MdiIcons.cellphone, (){})
       ]),
  
 Row( mainAxisAlignment: MainAxisAlignment.center,
  children: [ const SizedBox( width: 50,),
      const Text('Don\'t have an account?', style: TextStyle(fontSize: 15),),
TextButton(onPressed: (){
Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){ return
const Signup();
}));
}, child: const Text('Sign up',)) ],)]
 )
 )
    );
  }

Widget signupFields(String data, TextEditingController controller) {
bool isPassword = data == 'Password';

return Padding( padding: const EdgeInsets.only( right: 30, left: 30, bottom: 15),
child: TextField( controller: controller, obscureText: isPassword? obscureText : false,
decoration: InputDecoration( filled: true, fillColor: Colors.white, 
suffixIcon: isPassword? IconButton(onPressed: (){
setState(() {
obscureText = !obscureText;
});
}, icon:  Icon( obscureText == true ? Icons.visibility_off: Icons.visibility)): null,
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