import 'package:flutter/material.dart';

// import 'package:flutter_qr_reader/models/models.dart';


import '../widget/widget.dart';

class MapHistory extends StatelessWidget {
  const MapHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // data.getScans();
    return ScanListView( icon: Icons.map_outlined, );
  }
}


