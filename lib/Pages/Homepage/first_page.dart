import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(width: 1, color: Colors.black)),
            ),
          ),
         const HeroSection(
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: Text('See all',
                      style: TextStyle(
                          color: Colors.blue[400],
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                )
              ],
            ),
          ),
         const Expanded(child: ProductsDisplay())
        ]),
      ),
    );
  }

 
}

class ChipBrands extends StatelessWidget {
  final String label;
  final String brand;
  final bool isSelected;
  final ValueChanged<String> onPressed;

  const ChipBrands({
    super.key,
    required this.label,
    required this.brand,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed(brand); 
      },
      child: Chip(
        padding: const EdgeInsets.all(7),
        backgroundColor: isSelected ? Colors.blue[400] : Colors.grey[300],
        label: Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});
 

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  final PageController _controller = PageController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> products = [
      {
        'imageUrl': 'images/footwears/nikebanner.png',
        'brand' : 'Nike',
        'name': 'Nike AirMax',
        'text': 'SNEAKERS OF\nTHE WEEK',
        'discount': '40% Off!',
        'logo': 'images/icons/nike_logo.png'
      },
      {
        'imageUrl': 'images/footwears/adidasbanner.png',
        'brand': 'Adidas',
        'name': 'Nike UltraBoost',
        'text': 'KICK OFF\nSAVINGS',
        'discount': '70% Off!',
        'logo': 'images/icons/adidas_logo.png'
      },
      {
        'imageUrl': 'images/footwears/nbbanner.png',
        'brand': 'New Balance',
        'name': 'Air Jordan',
        'text': 'FLASH\nSALES',
        'discount': 'Coupon',
        'logo': 'images/icons/newbalance_logo.png'
      },
    ];
    return Column(
      children: [
        SizedBox(
          height: 210, width: double.infinity,
          child: productBanner(products),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
          controller: _controller,
          count: products.length,
          effect: const ExpandingDotsEffect(
            dotHeight: 8,
            dotWidth: 8,
            activeDotColor: Colors.blue,
            dotColor: Colors.grey,
          ),
        ),
      ],
    );
  }

  PageView productBanner(List<Map<String, dynamic>> products) {
    return PageView.builder(
        itemCount: products.length,
        controller: _controller,
        itemBuilder: (context, index) {
          final bannerInfo = products[index];
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Card(
              color: Colors.blue[400],
              elevation: 40,
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          bannerInfo['logo'],
                          width: 50,
                        ),
                        Text(
                          bannerInfo['text'],
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                        ),
                        const SizedBox(height: 5),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 2,
                          ),
                          onPressed: (){
                          },
                          child: Text(
                            bannerInfo['discount'],
                            style: const TextStyle(
                                fontSize: 25, color: Colors.blue),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Image.asset(bannerInfo['imageUrl'], width: 230)
                  ],
                ),
              ),
            ),
          );
        });
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
