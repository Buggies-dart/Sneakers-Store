import 'package:flutter/material.dart';
import 'package:sneaker_store_app/Pages/OtherPages/product_page.dart';
import 'package:sneaker_store_app/main/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WishlistPage extends ConsumerWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartInfo = ref.watch(myNotifProvider).cart;
    final wishList = ref.watch(myNotifProvider).wishList;
    return Scaffold(
      appBar: AppBar( backgroundColor: Colors.white,
        title: const Text('WishList'),
        centerTitle: true,
      ),
      body: wishList.isEmpty
        ? const Center(
            child: Text('Your wishlist is empty!'),
          )
      :SafeArea(
        top: true,
        child: ListView.builder(
          itemCount: wishList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final wish = wishList[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.grey[200],
                width: double.infinity,
                height: 166,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView( scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        Image.asset(
                          wish['imageUrl'].toString(),
                          width: 80,
                          height: 200,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                wish['name'].toString(),
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(wish['brand'].toString()),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {
                        bool productExists = cartInfo.any((product) => product['name'] == wish['name']);
        if (productExists) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.grey[200],
        content: const Row(
          children: [
            Icon(Icons.warning, color: Colors.red),
            SizedBox(width: 10),
            Text(
              'Product already added to your cart',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

else{
  showSnackBar(context, 'Product Added SuccessFully');
  ref.watch(myNotifProvider).addToCart(wish);
 ref.watch(myNotifProvider).removeWishList(wish);
}
},
label: const Text(
'Add To Cart',
style: TextStyle(color: Colors.black),
),
style: ElevatedButton.styleFrom(
backgroundColor: Colors.blue[400]),
),
const SizedBox(
width: 5,
),
ElevatedButton.icon(
onPressed: () {},
label: const Text('Checkout',
style: TextStyle(color: Colors.black)),
style: ElevatedButton.styleFrom(),
),
const SizedBox(
                                    width: 15,
                                  ),
                                 IconButton( onPressed: ()=> showCustomDialog(context, ref, wish), icon: const Icon( Icons.delete,  color: Colors.red),
                                   ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
void showCustomDialog(BuildContext context, WidgetRef ref, Map<String, dynamic> index) {
 showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Remove From WishList'),
        content: const Text('Are you sure you want to remove this product?'),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No', style: TextStyle(color: Colors.blue[400]),),
              ),
              TextButton(
                onPressed: () {
                  ref.watch(myNotifProvider).removeWishList(index);
                  Navigator.of(context).pop();
                },
                child: const Text('Yes', style: TextStyle(color: Colors.red),),
              ),
            ],
          ),
        ],
      );
    },
  );
}