import 'package:flutter/material.dart';

class AddreshOrderDetailItemWidget extends StatelessWidget {
  final String address;
  const AddreshOrderDetailItemWidget({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      color: Colors.white,
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Info Pengiriman",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Alamat"),
                  SizedBox(width: MediaQuery.of(context).size.width / 4),
                  Expanded(
                    child: Text(
                      address,
                      maxLines: 5,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
