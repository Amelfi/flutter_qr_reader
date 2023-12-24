import 'package:flutter/material.dart';
// import 'package:flutter_qr_reader/models/models.dart';
import 'package:flutter_qr_reader/providers/providers.dart';
import 'package:flutter_qr_reader/screens/address_screen.dart';
import 'package:flutter_qr_reader/screens/map_history.dart';
import 'package:flutter_qr_reader/widget/widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Qr Reader',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Provider.of<ScanListProvider>(context, listen: false).deleteAllScans();

              },
              icon: const Icon(
                Icons.delete_forever,
              color: Colors.white,
              ))
        ],
      ),
      body: _HomePageBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
      bottomNavigationBar: const CustomNavigationBar(),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  // const _HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = Provider.of<UiProvider>(context);
    // final tempScan = ScanModel(valor: 'http://google.com');
    // DBProvider.db.getScanByType('http').then((value) => print(value.tipo));
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex.selectedMenuOpt) {
      case 0:
        scanListProvider.getScansByType('geo');
        return const MapHistory();
      case 1:
        scanListProvider.getScansByType('http');
        return const AddressScreen();

      default:
        // scanListProvider.getScansByType('geo');
        return const MapHistory();
    }
  }
}
