import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/providers/ui_provider.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<UiProvider>(context);

    return BottomNavigationBar(
        onTap: (int i) => currentIndex.selectedMenuOpt = i,
        backgroundColor: Colors.white,
        elevation: 0,
        currentIndex: currentIndex.selectedMenuOpt,
        selectedItemColor: Colors.blueAccent,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapas'),
          BottomNavigationBarItem(
              icon: Icon(Icons.qr_code), label: 'Direcciones')
        ]);
  }
}
