import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Products/product_list.dart';
import 'package:sneaker_store_app/main/main.dart';
import 'package:sneaker_store_app/common/product_page.dart';

class ProductCard extends ConsumerStatefulWidget {
  const ProductCard({super.key});

  @override
  ConsumerState<ProductCard> createState() => _ProductCardwidgetState();
}

class _ProductCardwidgetState extends ConsumerState<ProductCard> {
List<Map<String, dynamic>> randomItems = (List<Map<String, dynamic>>.from(products)..shuffle(Random())).take(6).toList();

  @override
  Widget build(BuildContext context) {
final provider = ref.watch(myNotifProvider);
final querySize = MediaQuery.of(context).size;
return Column(
children: [
SizedBox(  height: 650,
child: GridView.builder( shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,),
itemCount: randomItems.length, scrollDirection: Axis.vertical, padding: const EdgeInsets.all(10),itemBuilder: (context, index) {
final shoeProducts = randomItems[index];

return GestureDetector(onTap: () {Navigator.push( context,
MaterialPageRoute( builder: (context) {
return ProductPage( indices: shoeProducts,
);
},
),
);
},
child: Stack(
children: [ Padding( padding: const EdgeInsets.all(6),
child: SizedBox(width: querySize.width/1.3,
child: Card( elevation: 5, color:  Colors.white54,
child: SingleChildScrollView( scrollDirection: Axis.horizontal,
child: Column( children: [Padding(
padding: const EdgeInsets.only(top: 10, right: 20),
child: Text(shoeProducts['name'].toString(),
style: const TextStyle( fontSize: 20, fontWeight: FontWeight.bold,
color: Colors.black),
),
),
Padding(
padding:  EdgeInsets.only(right: querySize.width/8 ),
child: Text( '\$${shoeProducts['price']}'.toString(),
style: Theme.of(context).textTheme.bodyMedium,
),
),
Center( child: SizedBox( height: querySize.height/9, width: querySize.width/2.2 ,child: Container( color: null,
child: Image.asset(shoeProducts['imageUrl'],
fit: BoxFit.contain ,),),
),
),
const SizedBox(height: 5),
],
),
),
),
),
),
                  
Positioned( top: -16, right: 3,
child: Consumer(builder: (context, ref, child) {
return Padding( padding: const EdgeInsets.only(top: 10), 
child: IconButton(onPressed: () {
if (provider.wishList.contains(shoeProducts)) {
provider.removeWishList(shoeProducts);
} else {
provider.addToWishList(shoeProducts); 
showSnackBar(context, 'Product Added SuccessFully');
}
},
icon: Icon( provider.wishList.contains(shoeProducts) ?
MdiIcons.heart : MdiIcons.heartOutline,
color:  provider.wishList.contains(shoeProducts) ? Colors.red : null
),
),
);
}),
),
],
),
);
},
),
),
],
);
  }
}
