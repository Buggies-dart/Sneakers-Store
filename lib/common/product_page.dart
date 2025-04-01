import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../main/main.dart';


class ProductPage extends ConsumerStatefulWidget {
  const ProductPage({super.key, required this.indices});
  
  final Map<String, dynamic> indices;
  
  @override
  ConsumerState<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends ConsumerState<ProductPage> {
  // Track the selected shoe size index
  int _selectedSizeIndex = -1;
  

  // Called when the page is initialized
  @override
  void initState() {
    super.initState();
    _selectedSizeIndex = -1; // Initialize to -1 (no selection)
  }  
  void addToCart() {
   
    if (_selectedSizeIndex == -1) {
      // If no size is selected, show a warning snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[200],
          content: const Row(
            children: [
              Icon(Icons.warning, color: Colors.red),
              SizedBox(width: 10),
              Text(
                'Please Select a Size',
                style: TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      );
    } else {
      Map<String, dynamic> productDetails = {
        'name': widget.indices['name'],
        'brand': widget.indices['brand'],
        'price': widget.indices['price'],
        'imageUrl': widget.indices['imageUrl'],
        'quantity': widget.indices['quantity']
      };
     final cartInfo = ref.watch(myNotifProvider).cart;
       bool productExists = cartInfo.any((product) => product['name'] == productDetails['name']);
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
  else{ref.read(myNotifProvider.notifier).addToCart(productDetails);
  showSnackBar(context, 'Product Added SuccessFully');}
   }
  }
 void addToWishList (){
  Map<String, dynamic> productDetails = {
        'name': widget.indices['name'],
        'brand': widget.indices['brand'],
        'imageUrl': widget.indices['imageUrl'],
      };
  ref.read(myNotifProvider.notifier).addToWishList(productDetails);
  showSnackBar(context, 'Product Added To Your WishList');
 
 }
  @override
  Widget build(BuildContext context) {
    final querySize = MediaQuery.of(context).size;
    final productInfo = widget.indices;
    return Scaffold( backgroundColor: Colors.grey[300],
      appBar: AppBar( 
        title: Text('Details', style: Theme.of(context).textTheme.headlineLarge),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      bottomNavigationBar: BottomAppBar( color: Colors.white, height: querySize.height/10,
        child: Padding( 
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton.icon( 
            onPressed: addToCart,
            label: Text(
              'Add To Cart',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            style: ElevatedButton.styleFrom( 
             
              backgroundColor: Colors.blue[400],
            ),
            icon: const Icon(Icons.shopping_bag, color: Colors.black, size: 30),
          ),
        ),
      ),
      body: Center(
        child: Column( crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align( alignment: Alignment.center,
              child: Text( 
                productInfo['brand'].toString(),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
              ),
            ),
            IconButton(onPressed: addToWishList, icon: Icon(MdiIcons.heartOutline, size: 30,
            ),
            splashColor: Colors.black,),
            Center(
              child: Container( color: null, height: MediaQuery.of(context).size.height/ 3.7,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Image.asset(productInfo['imageUrl'].toString(), fit: BoxFit.contain, ),
                )
                        ),
            ),
            Expanded(
              child: Container(  decoration: BoxDecoration( color: Colors.white, borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(40), topRight: Radius.circular(40)
                         ),
                        boxShadow: [BoxShadow(
                          color: Colors.black.withOpacity(0.2), 
                      spreadRadius: 5, 
                      blurRadius: 10, 
                      offset: const Offset(0, 10), 
                        )] ),
                child: SingleChildScrollView( scrollDirection: Axis.vertical,
                  child: Column(
                    children: [ Text( productInfo['name'].toString(), 
                    style: Theme.of(context).textTheme.bodyLarge),
                     Align( alignment: Alignment.topLeft,
                       child: Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Text( 
                          '\$${productInfo['price']}'.toString(),
                            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                       ),
                     ),
                    Padding(
                       padding: const EdgeInsets.only(left: 15),
                       child:  Row(
                         children: [
                            const Text('Select a Size', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),),
                            const SizedBox( width: 5,),
                            TextButton(onPressed: (){
                            }, child: const Text('View size guide'),)
                         ],
                       ),
                     ),
                      SizedBox(
                        height: querySize.height/19.5,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: (productInfo['sizes'] as List<int>).length,
                          itemBuilder: (context, index) {
                            final shoeSize = productInfo['sizes'][index].toString();
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedSizeIndex = index;
                                  });
                                },
                                child: Chip(
                                   shape: const CircleBorder(side: BorderSide( width: 1.5, color: Colors.black)),
                                  label: Text(shoeSize),
                                  backgroundColor: _selectedSizeIndex == index
                                      ? Colors.blue[400]
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(querySize.height/65),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Description',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(productInfo['description'].toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showSnackBar(BuildContext context, String message){
 ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.grey[200],
          content: Row(
            children: [
              Icon(Icons.done, color: Colors.blue[400]),
              const SizedBox(width: 10),
               Text(
                message,
                style: const TextStyle(color: Colors.black87),
              )
            ],
          ),
        ),
      );
}