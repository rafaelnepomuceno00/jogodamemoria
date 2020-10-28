import 'package:flutter/material.dart';

import 'home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Jogo da Memória',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
