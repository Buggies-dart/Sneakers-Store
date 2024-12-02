import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sneaker_store_app/Products/product_list.dart';
import 'package:sneaker_store_app/main/main.dart';
import 'package:sneaker_store_app/Pages/OtherPages/product_page.dart';

class ProductCardwidget extends ConsumerStatefulWidget {
    final String selectedBrand;

  const ProductCardwidget({super.key, required this.selectedBrand});

  @override
  ConsumerState<ProductCardwidget> createState() => _ProductCardwidgetState();
}

class _ProductCardwidgetState extends ConsumerState<ProductCardwidget> {
  @override
  Widget build(BuildContext context) {
        final querySize = MediaQuery.of(context).size;
     List<Map<String, dynamic>> allProducts = products.where((product) {
    return product['brand'] == widget.selectedBrand;
  }).toList();
   return Column(
      children: [
        Expanded(
child: GridView.builder(
gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
crossAxisCount: 2,),
itemCount: 5, scrollDirection: Axis.vertical, padding: const EdgeInsets.all(10),itemBuilder: (context, index) {
final shoeProducts = allProducts[index];

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
Center( child: SizedBox( height: querySize.height/8.05, width: querySize.width/2.2 ,child: Container( color: null,
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
return Padding( padding: const EdgeInsets.only(top: 10), // Positioned at the top-right corner
child: IconButton(onPressed: () {ref.watch(myNotifProvider).addToWishList(shoeProducts);
                 showSnackBar(context, 'Product Added SuccessFully');
              },
icon: Icon(
MdiIcons.heartOutline,
color: Colors.black54,
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
