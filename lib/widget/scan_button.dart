import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_qr_reader/providers/providers.dart';
import 'package:flutter_qr_reader/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final saveData = Provider.of<ScanListProvider>(context, listen: false);
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
            '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        // print(barcodeScanRes);

        if (barcodeScanRes == '-1') {
          return;
        }
        // saveData.addNewScan('https://google.com');

        final nuevoScan = await saveData.addNewScan(barcodeScanRes);
        print(nuevoScan);
        launchDataUrl(context, nuevoScan);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.filter_center_focus),
    );
  }
}
