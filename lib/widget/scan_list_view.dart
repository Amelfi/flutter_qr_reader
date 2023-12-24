import 'package:flutter/material.dart';
import 'package:flutter_qr_reader/providers/providers.dart';
import 'package:flutter_qr_reader/utils/utils.dart';
import 'package:provider/provider.dart';

class ScanListView extends StatelessWidget {
  final IconData icon;
  const ScanListView({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<ScanListProvider>(context);
    final scanList = data.scanList;
    return ListView.builder(
      itemCount: scanList.length,
      itemBuilder: (_, i) => Dismissible(
        onDismissed: (DismissDirection direccion) {
          Provider.of<ScanListProvider>(context, listen: false)
              .deleteScansById(scanList[i].id!.toInt());
        },
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueAccent),
          title: Text(scanList[i].valor),
          subtitle: Text('${scanList[i].id}'),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () async { // Make the onTap callback async
              try {
                await launchDataUrl(context, scanList[i]); // Await the async function call
              } catch (e) {
                print('Error: $e');
              }
            },
        ),
      ),
    );
  }
}
