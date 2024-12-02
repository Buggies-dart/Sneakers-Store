import 'package:flutter/material.dart';

void showSnackbar(
  BuildContext context, String text
){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void showdialogBox({
  required BuildContext context,
  required TextEditingController codeController,
  required VoidCallback onPressed}
){
  showDialog(context: context, barrierDismissible: false,
  builder: (context)=> AlertDialog(title: const Text('Enter Your OTP Code'),
  content: Column( mainAxisSize: MainAxisSize.min,
    children: [
      TextField(controller: codeController,)
    ],
  ),
 actions: <Widget>[TextButton(onPressed: onPressed, child: const Text('Done'))], )
  );
}