import 'package:flutter/material.dart';

void main() {
  runApp(MeuApp());
}

class MeuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white, 
      child: Center( 
        child: Text(
          'Hello, Flutter!',
          textDirection: TextDirection.ltr,
          style: TextStyle(
            fontSize: 50, 
            color: Colors.red
          ),
        ),
      ),
    );
  }
}