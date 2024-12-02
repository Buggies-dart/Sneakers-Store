import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sneaker_store_app/main/main.dart';


void couponBar (context, String text){
ScaffoldMessenger.of(context).showSnackBar(
SnackBar(content: Text(text, style: const TextStyle( color: Colors.black),),
backgroundColor: Colors.white,)
);
}

void showCustomDialog(BuildContext context, WidgetRef ref, Map<String, dynamic> index) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Remove From Cart'),
        content: const Text('Are you sure you want to remove this product?'),
        actions: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.blue[400]),
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.watch(myNotifProvider).removeCart(index);
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}