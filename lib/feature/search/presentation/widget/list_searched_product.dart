// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../core/constant/constant.dart';
import '../../../product/domain/entities/product_item.dart';
import '../../../product/presentation/page/detail_product_page.dart';

class ListSearchedProduct extends StatelessWidget {
  final List<ProductItem> itemList;
  const ListSearchedProduct({
    Key? key,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (itemList.isEmpty) {
      return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.error_outline,
              size: 50,
            ),
            Text("Pencarian Tidak di Temukan")
          ],
        ),
      );
    }

    return ListView.separated(
      itemCount: itemList.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 20);
      },
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => DetailProductPage(
                  productItem: itemList[index],
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(
                top: index == 0 ? 20 : 0,
                bottom: index == itemList.length - 1 ? 20 : 0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2)),
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://$baseUrl${itemList[index].urlImages.first.urlSmallImage}'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          itemList[index].productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.5,
                  color: Colors.black.withOpacity(.5),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
