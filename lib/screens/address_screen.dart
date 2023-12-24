import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/widget/widget.dart';


class AddressScreen extends StatelessWidget {

  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ScanListView(icon: Icons.home);
  }
}
