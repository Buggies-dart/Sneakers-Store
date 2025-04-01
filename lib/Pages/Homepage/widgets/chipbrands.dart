import 'package:flutter/material.dart';

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
