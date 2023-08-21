import 'package:flutter/material.dart';

import '../../domain/entities/order_history_entity.dart';

class OrderHistoryItemWidget extends StatefulWidget {
  final OrderHistoryEntity orderHistoryEntity;
  const OrderHistoryItemWidget({super.key, required this.orderHistoryEntity});

  @override
  State<OrderHistoryItemWidget> createState() => _OrderHistoryItemWidgetState();
}

class _OrderHistoryItemWidgetState extends State<OrderHistoryItemWidget> {
  @override
  Widget build(BuildContext context) {
    final orderItemList = widget.orderHistoryEntity.items;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              flex: 2,
              // height: 200,
              child: ListView.builder(
                itemExtent: 2, 
                physics: const NeverScrollableScrollPhysics(),
                itemCount: orderItemList.length,
                itemBuilder: (context, index) {
                  final singleOrderItem = orderItemList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                        child: Text(
                          singleOrderItem.productName,
                          maxLines: 2,
                        ),
                      ),
                      Text('x${singleOrderItem.qty}')
                    ],
                  );
                },
              ),
            ),
            const Flexible(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0),
                child: Divider(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
