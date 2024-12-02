import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store_app/Pages/Cartpage/cartpage.dart';
import 'package:sneaker_store_app/Pages/Homepage/first_page.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Pages/UserPage/user_page.dart';
import 'package:sneaker_store_app/Pages/WishListPage/wishlist_page.dart';
import 'main/main.dart';



class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
List<Widget> navbars = const [ProductCard(), WishlistPage(), Cartpage(), UserPage()];
    int index = 0;
@override
  Widget build(BuildContext context) {
    final wishList = ref.watch(myNotifProvider).wishList;
    final cartList = ref.watch(myNotifProvider).cart;
 return Scaffold( 
      body: 
      navbars[index],
     bottomNavigationBar: BottomAppBar( color: Colors.white54, height: 90,
       child: BottomNavigationBar(  elevation: 10, backgroundColor: Colors.black,
       unselectedItemColor: const Color.fromARGB(255, 183, 185, 185),
       items:  [ const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
       BottomNavigationBarItem(icon: 
       buttonStack2(wishList), label: 'WishList'),
           BottomNavigationBarItem(icon: buttonStack(cartList), label: 'Cart'),
         const BottomNavigationBarItem(icon:  Icon(Icons.portrait), label: 'User'
             ) 
             ]
           ,currentIndex: index, iconSize: 30, selectedItemColor: Colors.blue[400], 
           onTap: (value) { setState(() {
         index = value;
           });
        },
        ),
     ),
       
       
      );
  }

Stack buttonStack2(List<Map<String, dynamic>> wishList) {
  return Stack(children: [Icon(MdiIcons.heart), if(wishList.isNotEmpty)  Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                ),
              ),

     
     ] );
}

Stack buttonStack(List<Map<String, dynamic>> cartList) {
  return Stack(children: [ 
      Icon(MdiIcons.cart),  
        if(cartList.isNotEmpty)  Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 10,
                    minHeight: 10,
                  ),
                ),
              ),]);
}


}