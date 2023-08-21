import 'package:flutter/material.dart';

class SubItemTypeWidget extends StatelessWidget {
  final List<String> subTypeItem;
  final String titleItem;
  const SubItemTypeWidget(
      {super.key, required this.titleItem, required this.subTypeItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Text("$titleItem : "),
              ...subTypeItem
                  .map(
                    (e) => Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: const BorderSide(color: Colors.green),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.5),
                        child: Text(e),
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
