  import 'package:flutter/material.dart';

class Toast {
  Future? showToast(BuildContext context, text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(text),
        duration: Duration(seconds:2),
      ),
    );
  } 
}