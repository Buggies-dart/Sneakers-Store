import 'package:flutter/material.dart';
import 'package:sneaker_store_app/Pages/Homepage/widgets/home_products.dart';
import 'package:sneaker_store_app/Pages/Homepage/widgets/product_cardwidget.dart';

class ProductsDisplay extends StatefulWidget {
  const ProductsDisplay({super.key});

  @override
  State<ProductsDisplay> createState() => _ProductsDisplayState();
}

class _ProductsDisplayState extends State<ProductsDisplay> {
  final List<String> _buttonLabels = ['Best Sellers', 'Nike', 'Adidas','New Balance', 'Vans'];
 int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {

final List<Widget> contentWidgets = [
    const Center(child: ProductCard()),
     Center(child: ProductCardwidget(selectedBrand: _buttonLabels[1])),
     Center(child: ProductCardwidget(selectedBrand: _buttonLabels[2])),
     Center(child: ProductCardwidget(selectedBrand: _buttonLabels[3])),
     Center(child: ProductCardwidget(selectedBrand: _buttonLabels[4])),
    
  ];
 return Column( children: [
  SingleChildScrollView(  scrollDirection: Axis.horizontal,
    child: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
     children: List.generate(_buttonLabels.length, (index){
      return Padding(
        padding: const EdgeInsets.only(left: 5, right: 5),
        child: ElevatedButton( style:  ElevatedButton.styleFrom( backgroundColor: 
        _currentIndex == index? Colors.blue[400] : null),
          onPressed: (){
            setState(() {
                      _currentIndex = index; 
                    });
        }, child:  Text(_buttonLabels[index], style: const TextStyle(
          color: Colors.black
        ),),),
      );
     }),
     ),
  ),
    Expanded(
      child: IndexedStack(
         index: _currentIndex,
                children: contentWidgets,
      ),
    )]
 );
 
  }
}

