import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Pages/WishListPage/wishlist_page.dart';
import 'package:sneaker_store_app/authentication/firebase_auth/firebase_auth.dart';


class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:40),
            child: ListTile( leading: const Icon(Icons.person),title:  
            const Text('Hello, Olabisi', style:TextStyle(fontSize: 18)),
            tileColor: Colors.blue[400],
            subtitle: const Text('Labisi@gmail.com', style: TextStyle(fontSize: 16)), ),
        ),
      TextButton(onPressed: (){}, child:  Row(
        children: [ const Icon(Icons.pending, color: Colors.black,),
        const SizedBox( width:  5,),
          Text('Pending Orders', style: Theme.of(context).textTheme.bodyMedium,),
        ],
      )),
      ListTile( title: Text('My Buggies Account', style: Theme.of(context).textTheme.bodyMedium), tileColor:  const Color.fromARGB(255, 183, 185, 185),),
       ListTilee(leading:  const Icon(Icons.sell_outlined), text: 'Orders', onTap:() {},),
       ListTilee(leading:  Icon(MdiIcons.heart), text: 'Saved Items', onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return const WishlistPage();
        }));
       },),
       ListTilee(leading: const Icon(Icons.money_off), text: 'Refund Policy', onTap: (){},),
       ListTilee(leading: const Icon(Icons.policy), text: 'Privacy Policy', onTap: (){}),
       ListTilee(leading: const Icon(Icons. unsubscribe_rounded), text: 'Terms and Conditions', onTap: (){} ),
      ListTile( title: Text('Account Settings', style: Theme.of(context).textTheme.bodyMedium), tileColor:  const Color.fromARGB(255, 183, 185, 185),),
      accountSettings('Change Password', context, () async{
      await FirebaseAuthMethods(FirebaseAuth.instance).resetPassword(context);
      }),
      accountSettings('Sign Out', context, (){}),
      accountSettings('Delete Account', context, (){} )],
      ), 
    );
  }
}
Widget accountSettings(String text,  BuildContext context, VoidCallback onTap){return ListTile( onTap: onTap,
  title: Text(text, style: Theme.of(context).textTheme.bodyMedium), trailing: const Icon(Icons.navigate_next),
 );
}
class ListTilee extends StatelessWidget {
  const ListTilee({super.key, required this.leading, required this.text, required this.onTap});
 final Widget leading;
 final String text;
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile( leading: leading, title: Text(text, style: Theme.of(context).textTheme.bodyMedium,), trailing: const Icon(Icons.navigate_next), onTap: onTap,);
  }
}