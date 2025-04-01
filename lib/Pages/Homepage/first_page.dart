import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sneaker_store_app/Pages/Homepage/widgets/herosection.dart';
import 'package:sneaker_store_app/Pages/Homepage/widgets/special_offer.dart';
import 'package:sneaker_store_app/common/products_display.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

 @override
  Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text(
'Discover',
style: Theme.of(context).textTheme.headlineLarge,
),
centerTitle: false,
actions: [
IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
],
),
body: Padding(
padding: const EdgeInsets.only(top: 10),
child: Column(children: [
Padding( padding: const EdgeInsets.all(8.0),
child: CupertinoSearchTextField( decoration: BoxDecoration( color: Colors.white70,
borderRadius: BorderRadius.circular(25),
border: Border.all(width: 1, color: Colors.black)),
),
),
const HeroSection(),
sectionTitle(context, 'Special for you', (){}),
const SpecialOffers(),
const SizedBox(height: 10),
sectionTitle(context, 'Categories', (){}),
const Expanded(child: ProductsDisplay())
]),
),
);
  }

 Padding sectionTitle(BuildContext context, String title, VoidCallback seeAll) {
return Padding( padding: const EdgeInsets.only(left: 10),
child: Row(
children: [
Text( title, style: Theme.of(context).textTheme.bodySmall,),
const Spacer(),
TextButton(onPressed: seeAll,
child: Text('See all', style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold,
fontSize: 15)),
)
],
),
);
 }

}




// Search Function
// class SneakerSearch extends SearchDelegate<Map<String,dynamic>>{
 
// @override
// Widget buildLeading(BuildContext context)=> IconButton(onPressed: (){},
// icon: const Icon(Icons.clear),);
// @override
// Widget buildLeading(BuildContext context)=> ProductPage(indices: );
// @override
// Widget buildResults(BuildContext context)=> Container();
// @override
// Widget buildSuggestions(BuildContext context)=> Container();

// }
