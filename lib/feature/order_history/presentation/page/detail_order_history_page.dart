import 'package:flutter/material.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/checkout/presentation/page/payment_page.dart';
import 'package:flutter_fic_ecommerce_warung_comicon/feature/order_history/data/extension/order_status_to_entity.dart';

import '../../domain/entities/order_history_entity.dart';
import '../widget/addresh_order_detail_item_widget.dart';
import '../widget/card_order_item_widget.dart';

class DetailOrderHistoryPage extends StatefulWidget {
  final OrderHistoryEntity orderHistoryEntity;
  const DetailOrderHistoryPage({super.key, required this.orderHistoryEntity});

  @override
  State<DetailOrderHistoryPage> createState() => _DetailOrderHistoryPageState();
}

class _DetailOrderHistoryPageState extends State<DetailOrderHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Pesanan"),
      ),
      backgroundColor: Colors.grey[400],
      bottomNavigationBar: Container(
        color: Colors.white,
        height: 60,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextButton(
            onPressed: widget.orderHistoryEntity.orderStatus == "waitingPayment"
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentPage(
                          paymentUrl: widget.orderHistoryEntity.urlPayment,
                        ),
                      ),
                    );
                  }
                : null,
            style: TextButton.styleFrom(
              backgroundColor: Colors.green[400],
              disabledBackgroundColor: Colors.grey
            ),
            child: const Text(
              "Lanjutkan Pembayaran",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.orderHistoryEntity.orderStatus.toOrderStatusEntity,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Tanggal Pembelian"),
                      Text(
                        widget.orderHistoryEntity.createdOrderAt,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            );
          }

          if (index == 1) {
            return Container(
              padding: const EdgeInsets.all(8.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Detail Product",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: widget.orderHistoryEntity.items
                          .map(
                            (e) => CardOrderDetailItemWidget(
                              imageUrl: e.urlImage,
                              productName: e.productName,
                              productQtyItem: e.qty,
                              productPrice: e.price.toDouble(),
                            ),
                          )
                          .toList(),
                    ),
                  )
                ],
              ),
            );
          }

          if (index == 2) {
            return AddreshOrderDetailItemWidget(
              address: widget.orderHistoryEntity.deliveryAddress,
            );
          }

          // if (index == 3) {
          //   return Container(
          //     padding: const EdgeInsets.all(8.0),
          //     color: Colors.white,
          //     child: Expanded(
          //       child: Column(
          //         crossAxisAlignment: CrossAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         children: [
          //           const Text(
          //             "Rincian Pembayaran",
          //             style: TextStyle(fontWeight: FontWeight.bold),
          //           ),
          //           Padding(
          //             padding: const EdgeInsets.symmetric(vertical: 8.0),
          //             child: Row(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //               children: [
          //                 const Text("Metode Pembayaran"),
          //                 const Text(
          //                   "Gopay",
          //                   maxLines: 2,
          //                 ),
          //               ],
          //             ),
          //           )
          //         ],
          //       ),
          //     ),
          //   );
          // }

          return Container();
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 4,
      ),
    );
  }
}
