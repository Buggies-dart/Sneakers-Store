import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HeroSection extends StatefulWidget {
  const HeroSection({super.key});
 

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
int _currentPage = 0;
late Timer timer;
final PageController _controller = PageController();
 
@override
  void initState() {
super.initState();
_startAutoScroll();
}

void _startAutoScroll() {
 timer = Timer.periodic( const Duration(seconds: 4), (timer) {
if (_currentPage < products.length - 1) {
 _currentPage++;
} else {
_currentPage = 0; // Reset to first page
}
 _controller.animateToPage(
_currentPage, duration: const Duration(milliseconds: 500),
curve: Curves.easeInOut,
);
});
  }

 @override
  void dispose() {
timer.cancel();
_controller.dispose();
super.dispose();
  }


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
  @override
  Widget build(BuildContext context) {
    
    return Column(
children: [
SizedBox(
height: 210, width: double.infinity, child: productBanner(products),
),

const SizedBox(height: 10),
SmoothPageIndicator(
controller: _controller,
count: products.length,
effect: const ExpandingDotsEffect(
dotHeight: 8, dotWidth: 8,
activeDotColor: Colors.blue,
dotColor: Colors.grey,
),
        ),
      ],
    );
  }

PageView productBanner(List<Map<String, dynamic>> products) {
return PageView.builder(
itemCount: products.length, controller: _controller, onPageChanged: (index) {
setState(() {
_currentPage = index;
});
},
itemBuilder: (context, index) {
final bannerInfo = products[index];
return BackdropFilter(
filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),

child: Card( color: Colors.blue[400], elevation: 40, shadowColor: Colors.black,
child: Padding(
padding: const EdgeInsets.all(8.0),
child: Row(
children: [
Column( children: [
Image.asset(
bannerInfo['logo'], width: 50,),
Text( bannerInfo['text'], style: const TextStyle( fontSize: 22, color: Colors.black),
),
const SizedBox(height: 5),
ElevatedButton( style: ElevatedButton.styleFrom(elevation: 2,),
onPressed: (){},
child: Text( bannerInfo['discount'], style: const TextStyle(
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