import 'package:flutter/material.dart';


class SpecialOffers extends StatelessWidget {
  const SpecialOffers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
SingleChildScrollView(
scrollDirection: Axis.horizontal,
child: Row(
children: [
SpecialOfferCard( image: "images/footwears/run.png", category: "Running",
numOfBrands: 7,
press: () {},
),
SpecialOfferCard(
image: "images/footwears/2002r.png",
category: "Retro",
numOfBrands: 9,
press: () {},
),
SpecialOfferCard(
image: "images/footwears/2002r.png",
category: "Athletic",
numOfBrands: 5,
press: () {},
),
const SizedBox(width: 20),
],
),
),
],
);
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    super.key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  });

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
return Padding(padding: const EdgeInsets.only(left: 20),
child: GestureDetector( onTap: press, 
child: SizedBox(
width: 242, height: 100,
child: ClipRRect( borderRadius: BorderRadius.circular(20),
child: Stack(
children: [
Container( width: 242, color: null,
  child: Image.asset(
  image,
  fit: BoxFit.cover,
  ),
),
Container(
decoration:  const BoxDecoration( 
gradient:  LinearGradient( begin: Alignment.topCenter, end: Alignment.bottomCenter,
colors: [Colors.black54,Colors.black38, Colors.black26, Colors.transparent,],
),
),
),
Padding(
padding: const EdgeInsets.symmetric(
horizontal: 15, vertical: 10,
 ),
child: Text.rich(
TextSpan(
style: const TextStyle(color: Colors.white),
children: [
TextSpan( text: "$category\n",
style: const TextStyle( fontSize: 18, fontWeight: FontWeight.bold,
),
),
TextSpan(text: "$numOfBrands Brands")
],
),
),
),
],
),
),
),
),
);
  }
}
