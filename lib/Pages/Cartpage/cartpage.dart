import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store_app/Pages/Cartpage/utils.dart';
import 'package:sneaker_store_app/main/main.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';


class Cartpage extends ConsumerStatefulWidget {
  const Cartpage({super.key});

  @override
  ConsumerState<Cartpage> createState() => _CartpageState();
}

class _CartpageState extends ConsumerState<Cartpage> {
  TextEditingController coupon = TextEditingController();
  bool isCouponApplied = false;
  String validCoupon = 'SAVE20';

  @override
  Widget build(BuildContext context) {
    final cartInfo = ref.watch(myNotifProvider).cart;
    final double totalPrice = cartInfo.fold(0, (sum, item) => sum + item['price'] * item['quantity']);
    final double shippingCost = totalPrice * 0.03;
    final double tax = totalPrice * 0.05;

    final double discount = isCouponApplied ? totalPrice * 0.20 : 0;
    final double discountedTotal = totalPrice - discount;

    // Reset Coupon if Cart is empty
    if (cartInfo.isEmpty && isCouponApplied) {
      setState(() {
        isCouponApplied = false;
        coupon.clear();
      });
    }

    return Scaffold(
      body: cartInfo.isEmpty
          ? const Center(
              child: Text('Please add a product to your cart'),
            )
          : SafeArea(
              child: Column(
                children: [
                  Text(
                    'Cart',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Expanded(
                    child: ListView.builder( shrinkWrap: true,
                      itemCount: cartInfo.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final cartIndex = cartInfo[index];
                        return Container(
                          padding: const EdgeInsets.all(8.0),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(1),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              productCard(cartIndex),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                   Text(
                                          cartIndex['name'].toString(),
                                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            icon: Icon(MdiIcons.cartRemove),
                                            onPressed: () => showCustomDialog(context, ref, cartIndex)),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      cartIndex['brand'].toString(),
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${cartIndex['price'].toString()}',
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                                        ),
                                        Row(
                                          children: [
                                            IconButton(
                                              onPressed: () {
                                                ref.watch(myNotifProvider.notifier).decrementProductQuantity(index);
                                              },
                                              icon: Icon(
                                                MdiIcons.minusCircle,
                                                color: cartIndex['quantity'] == 1 ? Colors.black12 : Colors.black,
                                              ),
                                            ),
                                            Text(
                                              cartIndex['quantity'].toString(),
                                              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                ref.watch(myNotifProvider.notifier).incrementProductQuantity(index);
                                              },
                                              icon: Icon(
                                                MdiIcons.plusCircle,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: TextField(
                              controller: coupon,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Color.fromARGB(255, 241, 238, 238),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                hintText: 'Enter Promo Code',
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(40, 60),
                            foregroundColor: Colors.black,
                            backgroundColor: Colors.blue[400],
                          ),
                          onPressed: () {
                            if (coupon.text == validCoupon && totalPrice <= 300) {
                              setState(() {
                                isCouponApplied = true;
                              });
                              couponBar(context, 'Coupon Applied Successfully!');
                            } else if (totalPrice > 300 ) {
                             couponBar(context, 'This Code is for Orders Below \$300');
                            }
                          else{
                            couponBar(context, 'Invalid Coupon Code');
                          }
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ),
                  productPrice(context, 'Sub Total', discountedTotal.toStringAsFixed(2)),
                  productPrice(context, 'Shipping Cost', shippingCost.toStringAsFixed(2)),
                  productPrice(context, 'Tax (5%)', tax.toStringAsFixed(2)),
                  productPrice(context, 'Discount', discount.toStringAsFixed(2)),
                  checkoutButton(context),
                ],
              ),
            ),
    );
  }

  ElevatedButton checkoutButton(BuildContext context) {
    return ElevatedButton.icon(
      iconAlignment: IconAlignment.end,
      onPressed: () {},
      label: Text(
        'Proceed To Checkout',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        fixedSize: const Size(double.infinity, 50),
        backgroundColor: Colors.blue[400],
        elevation: 10,
      ),
      icon: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 30),
    );
  }

  Card productCard(Map<String, dynamic> cartIndex) {
    return Card(
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        width: 100,
        height: 120,
        child: Image.asset(
          cartIndex['imageUrl'],
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

Widget productPrice(BuildContext context, String text, String funds) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Text(
          '\$$funds',
          style: const TextStyle(color: Colors.black),
        ),
      ],
    ),
  );
}
